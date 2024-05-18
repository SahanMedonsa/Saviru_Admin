import 'package:flutter/material.dart';

class FarmerDetailsCard extends StatefulWidget {
  const FarmerDetailsCard({super.key});

  @override
  State<FarmerDetailsCard> createState() => _FarmerDetailsCardState();
}

class _FarmerDetailsCardState extends State<FarmerDetailsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.amber,
    );
  }
}
