import 'package:adminapp/components/Colorpallet.dart';
import 'package:adminapp/models/dailycollectiontotal.dart';
import 'package:flutter/material.dart';

class VegetableTotalsScreen extends StatefulWidget {
  @override
  _VegetableTotalsScreenState createState() => _VegetableTotalsScreenState();
}

class _VegetableTotalsScreenState extends State<VegetableTotalsScreen> {
  Map<String, Map<String, int>>? vegetableTotalsByDate;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadVegetableTotals();
  }

  Future<void> loadVegetableTotals() async {
    vegetableTotalsByDate = await getVegetableTotalsByDate();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.Emerald_Green.withOpacity(0.2),
      appBar: AppBar(
        title: Text('Daily Collection', style:  TextStyle(
          fontWeight: FontWeight.bold
        ),),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : vegetableTotalsByDate == null || vegetableTotalsByDate!.isEmpty
              ? Center(
                  child: Text(
                    'No data available',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView(
                  padding: EdgeInsets.all(16.0),
                  children: vegetableTotalsByDate!.entries.map((dateEntry) {
                    String date = dateEntry.key;
                    Map<String, int> vegetableData = dateEntry.value;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: ExpansionTile(
                      
                        backgroundColor: ColorPalette.appBar_color.withOpacity(0.1),
                        title: Text(
                          date,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        children: vegetableData.entries.map((vegeEntry) {
                          String vegetable = vegeEntry.key;
                          int totalAmount = vegeEntry.value;
                      
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 150,
                                  child: Text(
                                    '$vegetable',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Text(
                                    ':',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                SizedBox(width: 20,),
                                Text(
                                  '$totalAmount kg',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }).toList(),
                ),
    );
  }
}
