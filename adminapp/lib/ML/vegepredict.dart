// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class PredictionPage extends StatefulWidget {
//   @override
//   _PredictionPageState createState() => _PredictionPageState();
// }

// class _PredictionPageState extends State<PredictionPage> {
//   final TextEditingController _temperatureController = TextEditingController();
//   final TextEditingController _soilPHController = TextEditingController();
//   final TextEditingController _humidityController = TextEditingController();
//   final TextEditingController _rainfallController = TextEditingController();

//   String _prediction = '';

//   Future<void> _predictVegetable() async {
//     final response = await http.post(
//       Uri.parse('http://127.0.0.1:5000/predict'), // Update this URL accordingly
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         'Temperature(C)': double.tryParse(_temperatureController.text),
//         'Soil pH': double.tryParse(_soilPHController.text),
//         'Humidity': int.tryParse(_humidityController.text),
//         'Rainfall': int.tryParse(_rainfallController.text),
//       }),
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       setState(() {
//         _prediction = data['prediction'];
//       });
//     } else {
//       setState(() {
//         _prediction = 'Error: Unable to get prediction.';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return 
     
//        Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _temperatureController,
//               decoration: InputDecoration(labelText: 'Temperature (°C)'),
//               keyboardType: TextInputType.number,
//             ),
//             TextField(
//               controller: _soilPHController,
//               decoration: InputDecoration(labelText: 'Soil pH'),
//               keyboardType: TextInputType.number,
//             ),
//             TextField(
//               controller: _humidityController,
//               decoration: InputDecoration(labelText: 'Humidity (%)'),
//               keyboardType: TextInputType.number,
//             ),
//             TextField(
//               controller: _rainfallController,
//               decoration: InputDecoration(labelText: 'Rainfall (1 for Yes, 0 for No)'),
//               keyboardType: TextInputType.number,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _predictVegetable,
//               child: Text('Predict Vegetable'),
//             ),
//             SizedBox(height: 20),
//             if (_prediction.isNotEmpty) 
//               Text(
//                 'Predicted Vegetable: $_prediction',
//                 style: TextStyle(fontSize: 20),
//               ),
//           ],
//         ),
//       );
    
//   }
// }
