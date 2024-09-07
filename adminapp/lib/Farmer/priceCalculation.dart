import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PredictionForm extends StatefulWidget {
  @override
  _PredictionFormState createState() => _PredictionFormState();
}

class _PredictionFormState extends State<PredictionForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _seedsPriceController = TextEditingController();
  final TextEditingController _fertilizerCostController =
      TextEditingController();
  final TextEditingController _insecticidesCostController =
      TextEditingController();
  final TextEditingController _rainedController = TextEditingController();
  final TextEditingController _workerCostController = TextEditingController();
  final TextEditingController _usdRateController = TextEditingController();
  final TextEditingController _fuelPriceController = TextEditingController();

  DateTime? _selectedDate;
  String? _prediction;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _getPrediction() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await http.post(
          Uri.parse('http://127.0.0.1:5000/predict'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'Seeds_Price': int.parse(_seedsPriceController.text),
            'Fertilizer_Cost': int.parse(_fertilizerCostController.text),
            'Insecticides_Cost': int.parse(_insecticidesCostController.text),
            'Rained': int.parse(_rainedController.text),
            'Worker_Cost': int.parse(_workerCostController.text),
            'USD_Rate': double.parse(_usdRateController.text),
            'Fuel_Price': double.parse(_fuelPriceController.text),
            'Month': _selectedDate!.month,
            'Day': _selectedDate!.day,
            'Year': _selectedDate!.year,
          }),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data.containsKey('prediction')) {
            // Check if the key exists
            setState(() {
              _prediction = data['prediction'].toString();
            });
          } else {
            print('Prediction key not found in the response');
          }
        } else {
          print('Failed to get prediction: ${response.statusCode}');
        }
      } catch (e) {
        print('Error occurred: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 1 / 3,
      height: height * 1 ,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _seedsPriceController,
                decoration: InputDecoration(labelText: 'Seeds Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter seeds price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _fertilizerCostController,
                decoration: InputDecoration(labelText: 'Fertilizer Cost'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter fertilizer cost';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _insecticidesCostController,
                decoration: InputDecoration(labelText: 'Insecticides Cost'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter insecticides cost';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _rainedController,
                decoration: InputDecoration(labelText: 'Rained (0 or 1)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter rained value (0 or 1)';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _workerCostController,
                decoration: InputDecoration(labelText: 'Worker Cost'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter worker cost';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _usdRateController,
                decoration: InputDecoration(labelText: 'USD Rate'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter USD rate';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _fuelPriceController,
                decoration: InputDecoration(labelText: 'Fuel Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter fuel price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text(_selectedDate == null
                    ? 'Select Date'
                    : 'Selected Date: ${_selectedDate!.toLocal()}'
                        .split(' ')[0]),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getPrediction,
                child: Text('Get Prediction'),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Predicted Value:',
                    style: TextStyle(fontSize: 20)),
                if (_prediction != null) ...[
                Text('$_prediction',
                    style: TextStyle(fontSize: 20)),
              ]
                ],
              )
              
            ],
          ),
        ),
      ),
    );
  }
}
