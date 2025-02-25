import 'package:adminapp/components/Colorpallet.dart';
import 'package:adminapp/components/Gtext.dart';
import 'package:adminapp/pages/dailycollectotal.dart';
import 'package:adminapp/pages/inquiryscreen.dart';
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
                child: VegetableTotalsScreen(),
              )),
          Expanded(
              flex: 6,
              child:InquiryScreen()
              ),
        ],
      ),
    );
  }
}
