import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double sliderValue = 50; // Default slider value
  bool deviceState = true; // Default device state
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("device1");

  @override
  void initState() {
    super.initState();
    _fetchDeviceData();
  }

  // Fetch device data from Firebase
  void _fetchDeviceData() {
    _dbRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        setState(() {
          sliderValue = (data["slidervalue"] as num).toDouble();
          deviceState = data["state"] as bool;
        });
      }
    });
  }

  // Update device data in Firebase
  void _updateDeviceData() {
    _dbRef.set({
      "state": deviceState,
      "slidervalue": sliderValue,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SwitchListTile(
              title: Text("Device State"),
              value: deviceState,
              onChanged: (value) {
                setState(() {
                  log(value.toString());
                  deviceState = value;
                });
                _updateDeviceData();
              },
            ),
            Text("Select a value:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Slider(
              value: sliderValue,
              min: 0,
              max: 100,
              divisions: 10,
              label: sliderValue.round().toString(),
              onChanged: (value) {
                setState(() {
                  log(value.toString());
                  sliderValue = value;
                });
                _updateDeviceData();
              },
            ),
            SizedBox(height: 20),
            
          ],
        ),
      ),
    );
  }
}
