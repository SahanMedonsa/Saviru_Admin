import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCropType;
  String? _selectedSoilType;
  String _prediction = '';

  final List<String> _cropTypes = [
    'Carrot',
    'Beans',
    'Capsicum',
    'Potato',
    'Cabbage'
  ];

  final List<String> _soilTypes = ['Sandy', 'Loamy', 'Black', 'Red', 'Clayey'];

  @override
  void initState() {
    super.initState();
    _selectedCropType = _cropTypes.isNotEmpty ? _cropTypes[0] : null;
    _selectedSoilType = _soilTypes.isNotEmpty ? _soilTypes[0] : null;
  }

  Future<void> _submitData() async {
    if (_formKey.currentState!.validate()) {
      final cropType = _selectedCropType;
      final soilType = _selectedSoilType;

      final url = 'http://10.0.2.2:5000/predict';

      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'Crop Type': cropType,
            'Soil Type': soilType,
          }),
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          setState(() {
            _prediction =
                responseData['Recommended Fertilizer'] ?? 'No prediction';
          });
        } else {
          setState(() {
            _prediction = 'Failed to get prediction';
          });
        }
      } catch (error) {
        setState(() {
          _prediction = 'Error: $error';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor Values'),
        centerTitle: true, // Center the text in the navbar
        backgroundColor: Colors.green, // Change the navbar color to green
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButtonFormField<String>(
                  value: _selectedCropType,
                  decoration: InputDecoration(
                    labelText: 'Crop Type',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                  items: _cropTypes.map((crop) {
                    return DropdownMenuItem<String>(
                      value: crop,
                      child: Text(crop),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCropType = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a crop type';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButtonFormField<String>(
                  value: _selectedSoilType,
                  decoration: InputDecoration(
                    labelText: 'Soil Type',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                  items: _soilTypes.map((soil) {
                    return DropdownMenuItem<String>(
                      value: soil,
                      child: Text(soil),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedSoilType = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a soil type';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Background color
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('Submit'),
              ),
              SizedBox(height: 20),
              if (_prediction.isNotEmpty)
                Text(
                  'Recommended Fertilizer: $_prediction',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
