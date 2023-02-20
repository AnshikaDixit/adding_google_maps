import 'dart:async';

import 'package:flutter/material.dart';
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
          icon: BitmapDescriptor.defaultMarker, ),
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Maps Demo')),
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            mapType: _defaultMapType,
            onCameraMove: _onCameraMove,
            markers: _markers,
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
