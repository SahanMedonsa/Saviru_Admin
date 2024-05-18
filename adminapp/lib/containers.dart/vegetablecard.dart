import 'package:adminapp/components/Colorpallet.dart';
import 'package:adminapp/components/Gtext.dart';
import 'package:flutter/material.dart';

class vegeCard extends StatelessWidget {
  final String Vegename;

  const vegeCard({super.key, required this.Vegename});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorPalette.Jungle_Green.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(16.0), // Adjust the radius as needed
      ),
      child: Container(
        width: 300,
        height: 100,
        decoration: BoxDecoration(
            color: ColorPalette.Jungle_Green.withOpacity(0.9),
            borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Gtext(
              text: Vegename,
              size: 24,
              color: Colors.white,
              fweight: FontWeight.w600),
        ),
      ),
    );
  }
}
