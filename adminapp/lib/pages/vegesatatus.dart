import 'package:adminapp/Validations/validator.dart';
import 'package:adminapp/components/Colorpallet.dart';
import 'package:adminapp/components/Gtext.dart';
import 'package:adminapp/components/textfiels.dart';
import 'package:adminapp/models/Vegestatusmodel.dart';
import 'package:adminapp/services/vegestatus_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';

class Vegesatatus extends StatefulWidget {
  const Vegesatatus({super.key});

  @override
  State<Vegesatatus> createState() => _VegesatatusState();
}

TextEditingController cabbage_price = TextEditingController();
TextEditingController capcicum_price = TextEditingController();
TextEditingController potat_price = TextEditingController();
TextEditingController brinjal_price = TextEditingController();
TextEditingController carrote_price = TextEditingController();

final VegestatusDatabaseService _vegedatabaseServices =
    VegestatusDatabaseService();

// Initialize with today's date
DateTime _selectedDate = DateTime.now();

class _VegesatatusState extends State<Vegesatatus> {
  void _cleardata() {
    setState(() {
      cabbage_price.clear();
      capcicum_price.clear();
      potat_price.clear();
      brinjal_price.clear();
      carrote_price.clear();
    });
  }

  // void _deletedata(){
  //   _vegedatabaseServices.deleteVege(veges);
  // }

  void _submitData() async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }

      VegetableStatus vege = VegetableStatus(
        date: Timestamp.fromDate(_selectedDate),
        carrot: double.tryParse(carrote_price.text) ?? 0.0,
        cabbage: double.tryParse(cabbage_price.text) ?? 0.0,
        potato: double.tryParse(potat_price.text) ?? 0.0,
        brinjal: double.tryParse(brinjal_price.text) ?? 0.0,
        capsicum: double.tryParse(capcicum_price.text) ?? 0.0,
      );

      await _vegedatabaseServices.addVege(vege);

      // Clear the form after submission
      _cleardata();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Data submitted successfully!"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to submit data: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }




   final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorPalette.Emerald_Green.withOpacity(0.2),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.03, horizontal: width * 0.03),
        child: Row(
          children: [
            //1st column
            Expanded(
              flex: 3,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      height: height * 0.7,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Gtext(
                                text: "Vegetable Status Update- daily",
                                size: 20,
                                color: Colors.black,
                                fweight: FontWeight.bold),
                            SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Gtextnm(text: "Today's Date: "),
                                const SizedBox(width: 10),
                                InkWell(
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: _selectedDate ?? DateTime.now(),
                                      firstDate: DateTime(2015),
                                      lastDate: DateTime(2101),
                                    );

                                    if (pickedDate != null) {
                                      setState(() {
                                        _selectedDate = pickedDate;
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 16.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Text(
                                      "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Gtextnm(text: "Carrot price :"),
                                SizedBox(width: 20),
                                SizedBox(
                                  width: 150,
                                  child: Textfields(
                                    keyboardType: TextInputType.number,
                                    label: "price",
                                    tcontroller: carrote_price,
                                    validator: (value) => Validator.validateEmptyText('Price', value),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Gtextnm(text: "Potato price :"),
                                SizedBox(width: 20),
                                SizedBox(
                                  width: 150,
                                  child: Textfields(
                                    keyboardType: TextInputType.number,
                                    label: "price",
                                    tcontroller: potat_price,
                                    validator: (value) => Validator.validateEmptyText('Price', value),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Gtextnm(text: "Cabbage price :"),
                                SizedBox(width: 20),
                                SizedBox(
                                  width: 150,
                                  child: Textfields(
                                    keyboardType: TextInputType.number,
                                    label: "price",
                                    tcontroller: cabbage_price,
                                    validator: (value) => Validator.validateEmptyText('Price', value),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Gtextnm(text: "Capsicum price :"),
                                SizedBox(width: 20),
                                SizedBox(
                                  width: 150,
                                  child: Textfields(
                                    keyboardType: TextInputType.number,
                                    label: "price",
                                    tcontroller: capcicum_price,
                                    validator: (value) => Validator.validateEmptyText('Price', value),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Gtextnm(text: "Brinjal price :"),
                                SizedBox(width: 20),
                                SizedBox(
                                  width: 150,
                                  child: Textfields(
                                    keyboardType: TextInputType.number,
                                    label: "price",
                                    tcontroller: brinjal_price,
                                    validator: (value) => Validator.validateEmptyText('Price', value),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 150,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromARGB(255, 255, 47, 47),
                                  ),
                                  child: MaterialButton(
                                    onPressed: _cleardata,
                                    child: Gtext(
                                        text: "Clear all data",
                                        size: 16,
                                        color: Colors.black,
                                        fweight: FontWeight.normal),
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorPalette.Jungle_Green,
                                  ),
                                  child: MaterialButton(
                                    onPressed: _submitData,
                                    child: Gtext(
                                        text: "Submit",
                                        size: 16,
                                        color: Colors.black,
                                        fweight: FontWeight.normal),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            //2nd colum
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: ListView(
                  children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Gtext(
                                    text: "Vegetable Status Update- daily (Rs.)",
                                    size: 20,
                                    color: Colors.black,
                                    fweight: FontWeight.bold),
                        ],
                      ),
                      SizedBox(height: 25,),
                    SizedBox(
                      width: width,
                      height: height * 0.9,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(width: 90, child: Gtextnm(text: "Date")),
                              Container(
                                  width: 60, child: Gtextnm(text: "Carrot")),
                              Container(
                                  width: 70, child: Gtextnm(text: "Cabbage")),
                              Container(
                                  width: 60, child: Gtextnm(text: "Brinjal")),
                              Container(
                                  width: 80, child: Gtextnm(text: "Capsicum")),
                            ],
                          ),
                          SizedBox(height: 15,),
                          Expanded(
                            // This is key to give the StreamBuilder's ListView.builder space to expand
                            child: StreamBuilder<QuerySnapshot<VegetableStatus>>(
                              stream: _vegedatabaseServices.getVege(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                }
                
                                List<QueryDocumentSnapshot<VegetableStatus>>
                                    veges = snapshot.data?.docs ?? [];
                                if (veges.isEmpty) {
                                  return Center(child: Text('No any content'));
                                }
                
                                return ListView.builder(
                                  shrinkWrap:
                                      true, // Ensure this ListView takes only the needed space
                                  itemCount: veges.length,
                                  itemBuilder: (context, index) {
                                    VegetableStatus vegetableStatus =
                                        veges[index].data();
                                        String vegeID = veges[index].id;
                                    return Card(
                                      child: Slidable(
                                         key: ValueKey(vegeID),
                                    endActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          backgroundColor: Colors.red,
                                          icon: Icons.delete,
                                          label: "Delete",
                                          onPressed: (_) {
                                            _vegedatabaseServices
                                                .deleteVege(vegeID);
                                          },
                                        ),
                                         SlidableAction(
                                          backgroundColor: Colors.green,
                                          icon: Icons.edit,
                                          label: "Edit",
                                          onPressed: (_) {
                                            _vegedatabaseServices.updateVege(vegeID, vegeID as VegetableStatus)
                                                ;
                                          },
                                        ),
                                      ],
                                    ),
                                        child: ListTile(
                                        
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                width: 120,
                                                child: Text(DateFormat("dd-MM-yyyy")
                                                    .format(vegetableStatus.date
                                                        .toDate())),
                                              ),
                                              Container(
                                                  width: 80,
                                                  child: Text(
                                                      "${vegetableStatus.carrot}")),
                                              Container(
                                                  width: 80,
                                                  child: Text(
                                                      " ${vegetableStatus.cabbage}")),
                                              Container(
                                                  width: 80,
                                                  child: Text(
                                                      "${vegetableStatus.potato}")),
                                              Container(
                                                  width: 80,
                                                  child: Text(
                                                      "${vegetableStatus.capsicum}")),
                                            ],
                                          ),
                                          // children: [
                                          //   Padding(
                                          //     padding: const EdgeInsets.all(8.0),
                                          //     child: Column(
                                          //       crossAxisAlignment: CrossAxisAlignment.start,
                                          //       children: [
                                          //         Text("Carrot: ${vegetableStatus.carrot}"),
                                          //         Text("Cabbage: ${vegetableStatus.cabbage}"),
                                          //         Text("Potato: ${vegetableStatus.potato}"),
                                          //         Text("Capsicum: ${vegetableStatus.capsicum}"),
                                          //         Text("Date: ${vegetableStatus.date.toDate()}"),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
