import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SimpleMap extends StatefulWidget {
  const SimpleMap({super.key});

  @override
  State<SimpleMap> createState() => _SimpleMapState();
}

class _SimpleMapState extends State<SimpleMap> {
  static const LatLng _kMapCenter =
      LatLng(26.84976407763883, 75.80064458465962);

  static const CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

  final Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  MapType _defaultMapType = MapType.normal;

  void _changeMapType() {
    setState(() {
      _defaultMapType = _defaultMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _kMapCenter;

  LatLng startLocation = LatLng(27.6683619, 85.3101895);
  LatLng endLocation = LatLng(27.6688312, 85.3077329);

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(_lastMapPosition.toString()),
          position: _lastMapPosition,
          infoWindow: const InfoWindow(
            title: 'DianApps',
            snippet: '5 Star Rating',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    });
  }

  PolylinePoints polylinepoints = PolylinePoints();

  String googleAPiKey = "YOUR_KEY_HERE";

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    _markers.add(
      Marker(
        markerId: MarkerId(startLocation.toString()),
        position: startLocation,
        infoWindow: const InfoWindow(
          title: 'Starting Point',
          snippet: 'Start Marker',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId(endLocation.toString()),
        position: endLocation,
        infoWindow: const InfoWindow(
          title: 'Destination Point',
          snippet: 'Destination Marker',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );

    getDirections();
    super.initState();
  }

  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinepoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(startLocation.latitude, startLocation.longitude),
        PointLatLng(endLocation.latitude, endLocation.longitude),
        travelMode: TravelMode.driving);

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    addPolyline(polylineCoordinates);
  }

  addPolyline(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.deepPurpleAccent,
        points: polylineCoordinates,
        width: 8);
    polylines[id] = polyline;
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Maps Demo')),
      body: Stack(
        children: [
          GoogleMap(
            zoomGesturesEnabled: true,
            myLocationEnabled: true,
            mapType: _defaultMapType,
            onCameraMove: _onCameraMove,
            markers: _markers,
            polylines: Set<Polyline>.of(polylines.values),
            onMapCreated: _onMapCreated,
            initialCameraPosition: _kInitialPosition,
          ),
          Container(
            margin: const EdgeInsets.only(top: 80, right: 10),
            alignment: Alignment.topRight,
            child: Column(children: [
              FloatingActionButton(
                elevation: 5,
                backgroundColor: Colors.teal[200],
                onPressed: _changeMapType,
                child: const Icon(Icons.layers),
              ),
              const SizedBox(
                height: 16.0,
              ),
              FloatingActionButton(
                onPressed: _onAddMarkerButtonPressed,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                backgroundColor: Colors.green,
                child: const Icon(Icons.add_location, size: 36.0),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
