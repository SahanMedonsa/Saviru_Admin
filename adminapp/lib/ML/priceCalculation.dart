import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ML Prediction App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PredictionForm(),
    );
  }
}

class PredictionForm extends StatefulWidget {
  @override
  _PredictionFormState createState() => _PredictionFormState();
}

class _PredictionFormState extends State<PredictionForm> {
  final _formKey = GlobalKey<FormState>();

  // Define controllers for the input fields
  final TextEditingController seedsPriceController = TextEditingController();
  final TextEditingController fertilizerCostController = TextEditingController();
  final TextEditingController insecticidesCostController = TextEditingController();
  final TextEditingController rainedController = TextEditingController();
  final TextEditingController workerCostController = TextEditingController();
  final TextEditingController usdRateController = TextEditingController();
  final TextEditingController fuelPriceController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  String prediction = '';

  // Function to send data to the Flask API and get a response
  Future<void> getPrediction() async {
    // Create the input data for the request
    final inputData = {
      'Seeds_Price': double.tryParse(seedsPriceController.text),
      'Fertilizer_Cost': double.tryParse(fertilizerCostController.text),
      'Insecticides_Cost': double.tryParse(insecticidesCostController.text),
      'Rained': int.tryParse(rainedController.text),
      'Worker_Cost': double.tryParse(workerCostController.text),
      'USD_Rate': double.tryParse(usdRateController.text),
      'Fuel_Price': double.tryParse(fuelPriceController.text),
      'Month': int.tryParse(monthController.text),
      'Day': int.tryParse(dayController.text),
      'Year': int.tryParse(yearController.text),
    };

    // Send a POST request to the Flask API
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/predict'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(inputData),
    );

    // Decode the response
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      setState(() {
        prediction = responseData['prediction'].toString();
      });
    } else {
      throw Exception('Failed to get prediction');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Milk Quality Prediction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Add text fields for input
              TextFormField(
                controller: seedsPriceController,
                decoration: InputDecoration(labelText: 'Seeds Price'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: fertilizerCostController,
                decoration: InputDecoration(labelText: 'Fertilizer Cost'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: insecticidesCostController,
                decoration: InputDecoration(labelText: 'Insecticides Cost'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: rainedController,
                decoration: InputDecoration(labelText: 'Rained (1 for Yes, 0 for No)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: workerCostController,
                decoration: InputDecoration(labelText: 'Worker Cost'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: usdRateController,
                decoration: InputDecoration(labelText: 'USD Rate'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: fuelPriceController,
                decoration: InputDecoration(labelText: 'Fuel Price'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: monthController,
                decoration: InputDecoration(labelText: 'Month'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: dayController,
                decoration: InputDecoration(labelText: 'Day'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: yearController,
                decoration: InputDecoration(labelText: 'Year'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: getPrediction,
                child: Text('Get Prediction'),
              ),
              SizedBox(height: 20),
              Text('Prediction: $prediction'),
            ],
          ),
        ),
      ),
    );
  }
}
