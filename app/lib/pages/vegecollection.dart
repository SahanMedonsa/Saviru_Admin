import 'package:app/components/Colorpallet.dart';
import 'package:app/components/Gtext.dart';
import 'package:flutter/material.dart';

class vegeCollection extends StatefulWidget {
  const vegeCollection({super.key});

  @override
  State<vegeCollection> createState() => _vegeCollectionState();
}

// Form fields
String location = '';
double space = 0.0;
String soilQuality = '';
String vegetables = '';
String wateringInfo = '';
String plantingInfo = '';
String pestManagement = '';
String fertilization = '';
String supports = '';
String harvesting = '';
String learning = '';

class _vegeCollectionState extends State<vegeCollection> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorPalette.forest_Green.withOpacity(0.2),
      body: Row(
        children: [
          Expanded(
              flex: 6,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        Gtext(
                            text: 'Choose the right type of vegetable ',
                            size: 25,
                            color: Colors.black,
                            fweight: FontWeight.w600),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Location'),
                          onChanged: (value) {
                            setState(() {
                              location = value;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a location';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Available Space (sq. ft)'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              space = double.tryParse(value) ?? 0.0;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty ||
                                double.tryParse(value) == null) {
                              return 'Please enter valid space';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Soil Quality'),
                          onChanged: (value) {
                            setState(() {
                              soilQuality = value;
                            });
                          },
                        ),
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Vegetables to Grow'),
                          onChanged: (value) {
                            setState(() {
                              vegetables = value;
                            });
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Watering Information'),
                          onChanged: (value) {
                            setState(() {
                              wateringInfo = value;
                            });
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Planting Information'),
                          onChanged: (value) {
                            setState(() {
                              plantingInfo = value;
                            });
                          },
                        ),
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Pest Management'),
                          onChanged: (value) {
                            setState(() {
                              pestManagement = value;
                            });
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Fertilization Details'),
                          onChanged: (value) {
                            setState(() {
                              fertilization = value;
                            });
                          },
                        ),
                        SizedBox(height: 40.0),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Submit form logic (e.g., save to database)
                              // Access form field values from state variables
                              // location, space, soilQuality, etc.
                            }
                          },
                          child: Text('Generate Suitable Vegetable'),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          Expanded(
              flex: 6,
              child: Column(
                children: [
                  Container(
                    height: height * 1 / 2,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Gtext(
                              text: 'Farmer Daily collections.',
                              size: 25,
                              color: Colors.black,
                              fweight: FontWeight.w600),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: height * 1 / 2,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Gtext(
                              text: 'Farmer Inquiry Details..',
                              size: 25,
                              color: Colors.black,
                              fweight: FontWeight.w600),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
