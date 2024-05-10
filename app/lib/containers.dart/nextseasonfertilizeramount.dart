import 'package:app/components/Gtext.dart';
import 'package:app/containers.dart/fertilizertypecard.dart';
import 'package:flutter/material.dart';

class nextseasonfertilizerstockcard extends StatelessWidget {
  const nextseasonfertilizerstockcard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Gtext(
            text: 'Required Stock for next season',
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
        fertilizertypecard(title: 'Uria', amount: '150'),
        fertilizertypecard(title: 'TSP', amount: '250'),
        fertilizertypecard(title: 'MOP', amount: '350'),
        fertilizertypecard(title: 'KIE', amount: '350'),
        fertilizertypecard(title: 'DOLOMITE', amount: '250'),
        fertilizertypecard(title: 'SOA', amount: '250'),
        fertilizertypecard(title: 'BORATE', amount: '150'),
      ],
    );
  }
}
