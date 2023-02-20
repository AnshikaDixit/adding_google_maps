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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Maps Demo')),
      body: Stack(
        children: [
          const GoogleMap(  
            initialCameraPosition: _kInitialPosition,
          ),
        ],
      ),
    );
  }
}
