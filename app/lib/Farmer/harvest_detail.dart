import 'package:app/Farmer/detail_row.dart';
import 'package:app/components/Gtext.dart';
import 'package:flutter/material.dart';

class harvestdetails extends StatelessWidget {
  final String vegetable;
  final String garea;
  final String honetime;
  final String season;
  final String price1kg;
  final String profit1kg;

  const harvestdetails({
    super.key,
    required this.vegetable,
    required this.garea,
    required this.honetime,
    required this.season,
    required this.price1kg,
    required this.profit1kg,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width / 4,
      // color: Colors.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gtextn(text: 'Personal Details'),
          const SizedBox(
            height: 10,
          ),
          DetailRow(detail: 'Vegetable ', fdetail: vegetable),
          DetailRow(detail: 'Grow Area (km2)  ', fdetail: garea),
          DetailRow(detail: 'Season Havest (kg)', fdetail: honetime),
          DetailRow(detail: 'Season ', fdetail: season),
          DetailRow(detail: 'Price for 1kg', fdetail: price1kg),
          DetailRow(detail: 'Profit for 1kg', fdetail: price1kg),
        ],
      ),
    );
  }
}
