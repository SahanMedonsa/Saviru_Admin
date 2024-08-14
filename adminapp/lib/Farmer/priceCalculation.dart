import 'package:flutter/material.dart';

class farmerpricecal extends StatefulWidget {
  const farmerpricecal({super.key});

  @override
  State<farmerpricecal> createState() => _farmerpricecalState();
}

class _farmerpricecalState extends State<farmerpricecal> {
  @override
  Widget build(BuildContext context) {
    return  Container(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    DropdownButtonFormField<String>(
                                      value: _selectedDistrict,
                                      items: [
                                        'Carrot',
                                        'Cabbage',
                                        'Potato',
                                        'Beans',
                                        'Capcicum'
                                      ]
                                          .map((district) =>
                                              DropdownMenuItem<String>(
                                                value: district,
                                                child: Text(district),
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedDistrict = value ??
                                              'Kalutara'; // Default to Kalutara if null
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Select Vegetable',
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    TextField(
                                      controller: _carrotController,
                                      decoration: const InputDecoration(
                                          labelText: 'Pre Workers Cost :'),
                                      keyboardType: TextInputType.number,
                                    ),
                                    const SizedBox(height: 20.0),
                                    TextField(
                                      controller: _potatoController,
                                      decoration: const InputDecoration(
                                          labelText: 'Seeds price :'),
                                      keyboardType: TextInputType.number,
                                    ),
                                    const SizedBox(height: 20.0),
                                    TextField(
                                      controller: _cabbageController,
                                      decoration: const InputDecoration(
                                          labelText: 'Fertilizer Cost :'),
                                      keyboardType: TextInputType.number,
                                    ),
                                    const SizedBox(height: 20.0),
                                    TextField(
                                      controller: _capsicumController,
                                      decoration: const InputDecoration(
                                          labelText: 'Insecticides Cost'),
                                      keyboardType: TextInputType.number,
                                    ),
                                    const SizedBox(height: 20.0),
                                    TextField(
                                      controller: _beansController,
                                      decoration: const InputDecoration(
                                          labelText: 'Transport cost'),
                                      keyboardType: TextInputType.number,
                                    ),
                                    SizedBox(height: 40.0),
                                    ElevatedButton(
                                      onPressed: _submitForm,
                                      child: Text('Submit'),
                                    ),
                                  ],
                                ),
                              );
  }

  late TextEditingController _carrotController;
  late TextEditingController _potatoController;
  late TextEditingController _cabbageController;
  late TextEditingController _capsicumController;
  late TextEditingController _beansController;

  String _selectedDistrict = 'Carrot'; // Default selected district

  @override
  void initState() {
    super.initState();
    _carrotController = TextEditingController();
    _potatoController = TextEditingController();
    _cabbageController = TextEditingController();
    _capsicumController = TextEditingController();
    _beansController = TextEditingController();
  }

  @override
  void dispose() {
    _carrotController.dispose();
    _potatoController.dispose();
    _cabbageController.dispose();
    _capsicumController.dispose();
    _beansController.dispose();
    super.dispose();
  }

  void _submitForm() {
    // Handle form submission here (e.g., save data to Firestore)
    // Clear text field values after submission
    _carrotController.clear();
    _potatoController.clear();
    _cabbageController.clear();
    _capsicumController.clear();
    _beansController.clear();
    setState(() {
      _selectedDistrict = 'Carrot'; // Reset district dropdown to default
    });
    // Show a dialog or perform further actions after submission
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Price Generated'),
        content: Text('Carrote cost : 45/-'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}