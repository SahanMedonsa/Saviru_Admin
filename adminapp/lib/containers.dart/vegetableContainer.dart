import 'package:adminapp/containers.dart/vegetablecard.dart';
import 'package:flutter/material.dart';

class vegetablecontainer extends StatelessWidget {
  const vegetablecontainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                vegeCard(Vegename: 'Carrot'),
                vegeCard(Vegename: 'Cabbage'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                vegeCard(Vegename: 'Beans'),
                vegeCard(Vegename: 'Capcicum'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                vegeCard(Vegename: 'Potato'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
