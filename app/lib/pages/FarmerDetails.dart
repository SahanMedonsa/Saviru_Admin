import 'package:app/components/Colorpallet.dart';
import 'package:app/components/DetailContainer.dart';
import 'package:app/services/farmer_db_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FarmerDetailsPage extends StatefulWidget {
  const FarmerDetailsPage({Key? key}) : super(key: key);

  @override
  State<FarmerDetailsPage> createState() => _FarmerDetailsPageState();
}

class _FarmerDetailsPageState extends State<FarmerDetailsPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  int fieldSum = 0;

  @override
  void initState() {
    super.initState();
    calculateFieldSum().then((sum) {
      setState(() {
        fieldSum = sum;
      });
    });
  }

  Future<int> calculateFieldSum() async {
    int sum = 0;

    try {
      QuerySnapshot querySnapshot = await firestore.collection('farmer').get();

      querySnapshot.docs.forEach((doc) {
        // Access the desired field inside each document
        // Here 'profite1kg' is the name of the field whose values you want to sum
        int fieldValue = doc['garea'] ?? 0; // Use 0 if field is null
        sum += fieldValue;
      });
    } catch (e) {
      print('Error fetching documents: $e');
    }

    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Row(
        children: [
          DetailContainer(
              Cicon: Icons.person,
              ctext: "Total Grow Area",
              count: fieldSum.toString(),
              Ccolor: ColorPalette.Jungle_Green)
        ],
      ),
    );
  }
}
