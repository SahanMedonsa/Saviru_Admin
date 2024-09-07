import 'package:adminapp/components/Colorpallet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:adminapp/components/Gtext.dart';

class VegetableContainer extends StatelessWidget {
  const VegetableContainer({super.key});

  Future<List<Map<String, dynamic>>> fetchAllData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference fertilizerCollection = firestore.collection('fertilizer');

    QuerySnapshot fertilizerSnapshot = await fertilizerCollection.get();
    List<Map<String, dynamic>> allData = [];

    for (var doc in fertilizerSnapshot.docs) {
      Map<String, dynamic> data = {};
      data['outletNo'] = doc['outletNo'];

      CollectionReference availableStockCollection = doc.reference.collection('Available stock');
      QuerySnapshot stockSnapshot = await availableStockCollection.get();

      stockSnapshot.docs.forEach((stockDoc) {
        Map<String, dynamic> stockData = stockDoc.data() as Map<String, dynamic>;
        data.addAll(stockData);
      });

      allData.add(data);
    }

    return allData;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchAllData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data found'));
        } else {
          List<Map<String, dynamic>> allData = snapshot.data!;

          return ListView.builder(
            itemCount: allData.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data = allData[index];
              String outlateno = data['outletNo'];
              List<String> stockKeys = data.keys.where((key) => key != 'outletNo').toList();
          
              return Padding(
                padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
                child: Container(
                  width: width * 0.6,
                  height: 40,
                  decoration: BoxDecoration(
                    color: ColorPalette.Jungle_Green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          width: 200,
                          child: Gtext(text: outlateno, size: 18, color: Colors.black, fweight: FontWeight.w600),
                        ),
                        ...stockKeys.map((key) => Gtext(
                              text: data[key].toString(),
                              size: 16,
                              color: Colors.black,
                              fweight: FontWeight.w400,
                            )),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
