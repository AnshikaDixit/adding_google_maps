import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Open Map',
              style: Theme.of(context).textTheme.headline4,
            ),
            FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/Map');
        },
        child: const Icon(Icons.location_city),
      ),
          ],
        ),
      ),
    );
  }
}
