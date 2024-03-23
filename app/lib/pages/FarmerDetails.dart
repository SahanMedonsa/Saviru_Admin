import 'package:app/services/farmer_db_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FarmerDetailsPAge extends StatefulWidget {
  const FarmerDetailsPAge({super.key});

  @override
  State<FarmerDetailsPAge> createState() => _FarmerDetailsPAgeState();
}

class _FarmerDetailsPAgeState extends State<FarmerDetailsPAge> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<int> calculateFieldSum() async {
    int sum = 0;

    try {
      QuerySnapshot querySnapshot =
          await firestore.collection('your_collection').get();

      querySnapshot.docs.forEach((doc) {
        // Access the desired field inside each document
        // Here 'field_name' is the name of the field whose values you want to sum
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
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          int fieldSum = await calculateFieldSum();
          print('Sum of field values: $fieldSum');
          // You can use the fieldSum for further processing or display
        },
        child: Text('Calculate Field Sum'),
      ),
    );
  }
}
