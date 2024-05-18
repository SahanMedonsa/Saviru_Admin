import 'package:adminapp/components/Gtext.dart';

import 'package:flutter/material.dart';

class fertilizertypecard extends StatelessWidget {
  final String title;
  final String amount;
  const fertilizertypecard(
      {super.key, required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Gtext(
              text: title,
              size: 22,
              color: Colors.black,
              fweight: FontWeight.w600),
          Gtext(
              text: amount,
              size: 22,
              color: Colors.black,
              fweight: FontWeight.w600),
        ],
      ),
    );
  }
}
