import 'package:app/components/Gtext.dart';
import 'package:app/containers.dart/fertilizertypecard.dart';
import 'package:flutter/material.dart';

class fertilizerstockcard extends StatelessWidget {
  const fertilizerstockcard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Gtext(
            text: 'Fertilizer Stock Availability',
            size: 25,
            color: Colors.black,
            fweight: FontWeight.w600),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Gtext(
                text: 'Fertilizer Type',
                size: 22,
                color: Colors.black,
                fweight: FontWeight.w600),
            Gtext(
                text: 'Quantity (Kg)',
                size: 22,
                color: Colors.black,
                fweight: FontWeight.w600),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        fertilizertypecard(title: 'Uria', amount: '50'),
        fertilizertypecard(title: 'Uria', amount: '50'),
        fertilizertypecard(title: 'Uria', amount: '50'),
        fertilizertypecard(title: 'Uria', amount: '50'),
        fertilizertypecard(title: 'Uria', amount: '50'),
        fertilizertypecard(title: 'Uria', amount: '50'),
      ],
    );
  }
}
