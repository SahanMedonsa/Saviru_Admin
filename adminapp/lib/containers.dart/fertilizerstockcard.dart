import 'package:adminapp/components/Gtext.dart';
import 'package:adminapp/containers.dart/fertilizertypecard.dart';
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
                text: 'Quantity (ton)',
                size: 22,
                color: Colors.black,
                fweight: FontWeight.w600),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        fertilizertypecard(title: 'Uria', amount: '250'),
        fertilizertypecard(title: 'TSP', amount: '150'),
        fertilizertypecard(title: 'MOP', amount: '250'),
        fertilizertypecard(title: 'KIE', amount: '450'),
        fertilizertypecard(title: 'DOLOMITE', amount: '350'),
        fertilizertypecard(title: 'SOA', amount: '150'),
        fertilizertypecard(title: 'BORATE', amount: '250'),
      ],
    );
  }
}
