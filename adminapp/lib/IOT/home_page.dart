import 'package:flutter/material.dart';
import 'sensor_values.dart';
import 'form_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
     Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SensorPage(),
                  ),
                );
              },
              child: Text('View Sensor Data'),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormPage(),
                  ),
                );
              },
              child: Text('Enter Crop and Soil Values'),
            ),
          ),
        ],
      
    );
  }
}
