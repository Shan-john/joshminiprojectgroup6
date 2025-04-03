import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class CurtainControlPage extends StatefulWidget {
  @override
  _CurtainControlPageState createState() => _CurtainControlPageState();
}

class _CurtainControlPageState extends State<CurtainControlPage> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  bool autoMode = true;
  double manualPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchCurtainData();
  }

  void _fetchCurtainData() {
    _database.child('curtain').onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        setState(() {
          autoMode = data['auto_mode'] ?? true;
          manualPosition = (data['manual_position'] ?? 0).toDouble();
        });
      }
    });
  }

  void _updateCurtainData() {
    _database.child('curtain').set({
      'auto_mode': autoMode,
      'manual_position': manualPosition,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('Curtain Control'),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.shade300,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Mode Selection',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[900]),
                        ),
                        SizedBox(height: 10),
                        SwitchListTile(
                          title: Text('Auto Mode', style: TextStyle(color: Colors.blue[900])),
                          value: autoMode,
                          onChanged: (value) {
                            setState(() {
                              autoMode = value;
                            });
                            _updateCurtainData();
                          },
                          activeColor: Colors.blue[900],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  if (!autoMode)
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.shade300,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Manual Position: ${manualPosition.toStringAsFixed(0)}%',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue[900]),
                          ),
                          Slider(
                            min: 0,
                            max: 100,
                            value: manualPosition,
                            onChanged: (value) {
                              setState(() {
                                manualPosition = value;
                              });
                              _updateCurtainData();
                            },
                            activeColor: Colors.blue[900],
                            inactiveColor: Colors.blue[300],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
