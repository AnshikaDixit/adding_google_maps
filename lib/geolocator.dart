import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyGeoLocation extends StatefulWidget {
  const MyGeoLocation({super.key});

  @override
  State<MyGeoLocation> createState() => _MyGeoLocationState();
}

class _MyGeoLocationState extends State<MyGeoLocation> {
  Completer<GoogleMapController> _controller = Completer();

  // on below line we have specified camera position
  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(20.42796133580664, 80.885749655962),
    zoom: 14.4746,
  );

  //list of markers
  final List<Marker> _markers = <Marker>[
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(20.42796133580664, 75.885749655962),
        infoWindow: InfoWindow(
          title: 'My Position',
        )),
  ];

  //method for getting user's current location
  Future<Position> getUserCurrentLoaction() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 174, 201),
        title:
            const Text("Find Location", style: TextStyle(color: Colors.black)),
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGoogle,
          markers: Set<Marker>.of(_markers),
          mapType: MapType.normal,
          myLocationEnabled: true,
          compassEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      // on pressing floating action button the camera will take to user current location
      floatingActionButton: FloatingActionButton(onPressed: () async {
        getUserCurrentLoaction().then((value) async {
          print(value.latitude.toString() + " " + value.longitude.toString());
          // marker added for current users location
          _markers.add(
            Marker(
              markerId: const MarkerId('2'),
              position: LatLng(value.latitude, value.longitude),
              infoWindow: const InfoWindow(title: 'My Current Location')));

          CameraPosition cameraPosition = CameraPosition(
            target: LatLng(value.latitude, value.longitude),
            zoom: 14,
          );

          final GoogleMapController controller = await _controller.future;
          controller
              .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
          setState(() {
            
          });
        });

        // specified current users location
      },
      child: const Icon(Icons.local_activity),),
    );
  }
}
