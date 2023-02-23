
import 'package:adding_google_maps/home.dart';
import 'package:adding_google_maps/geolocator.dart';
import 'package:adding_google_maps/location.dart';
import 'package:adding_google_maps/map.dart';
import 'package:adding_google_maps/places.dart';
import 'package:adding_google_maps/task.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        '/Map' :(context) => const SimpleMap(),
        '/GeoLocation' :(context) => const MyGeoLocation(),
        '/Location' :(context) => const LocationPage(),
        '/Places' :(context) => const Places(),
        '/MyTask' :(context) =>const Task(),
    
      },
    );
  }
}

