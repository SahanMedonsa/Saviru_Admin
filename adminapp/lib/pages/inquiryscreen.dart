import 'package:adminapp/components/Colorpallet.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InquiryScreen extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.Emerald_Green.withOpacity(0.2),
      appBar: AppBar(title: Text('Inquiry Details', style: TextStyle(fontWeight: FontWeight.bold),)),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('inquiry').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No data available'));
          }

          final inquiryDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: inquiryDocs.length,
            itemBuilder: (context, index) {
              final docData = inquiryDocs[index].data() as Map<String, dynamic>;

              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text('Vegetable: ${docData['expected_vegetable']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text('FID: ${docData['fID']}'),
                      
                      Text('Month: ${docData['expected_vegetable']}'),
                      Text('Fertilizer: ${docData['fertilizer']}'),
                      Text('Growing Area: ${docData['growing_area']}'),
                      Text('Soil Type: ${docData['soil_type']}'),
                      Text('Time Period: ${docData['time_period']} months'),
                      Text('Weather: ${docData['weather']}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
