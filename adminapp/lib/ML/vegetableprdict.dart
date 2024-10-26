import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VegetablePredictionScreen extends StatefulWidget {
  @override
  _VegetablePredictionScreenState createState() => _VegetablePredictionScreenState();
}

class _VegetablePredictionScreenState extends State<VegetablePredictionScreen> {
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController soilPHController = TextEditingController();
  final TextEditingController humidityController = TextEditingController();
  final TextEditingController rainfallController = TextEditingController();

  String predictionResult = "";

  Future<void> predictVegetable() async {
  final url = Uri.parse('http://127.0.0.1:5000/vegepredict'); // Replace with your Flask URL

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Temperature(C)': temperatureController.text,
        'Soil pH': soilPHController.text,
        'Humidity': humidityController.text,
        'Rainfall': rainfallController.text,
      }),
    );

    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      setState(() {
        predictionResult = jsonResponse['prediction']; 
      });
    } else {
      setState(() {
        predictionResult = 'Error: Unable to get prediction';
      });
    }
  } catch (e) {
    setState(() {
      predictionResult = 'Error: $e';
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: temperatureController,
            decoration: InputDecoration(
              labelText: 'Temperature (C)',
            ),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: soilPHController,
            decoration: InputDecoration(
              labelText: 'Soil pH',
            ),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: humidityController,
            decoration: InputDecoration(
              labelText: 'Humidity',
            ),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: rainfallController,
            decoration: InputDecoration(
              labelText: 'Rainfall (1 for Yes, 0 for No)',
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: predictVegetable,
            child: Text('Predict Vegetable'),
          ),
          SizedBox(height: 20),
          Text(
            'Prediction: $predictionResult',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
