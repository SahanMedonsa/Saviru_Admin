import 'package:adminapp/components/Colorpallet.dart';
import 'package:adminapp/components/Gtext.dart';
import 'package:adminapp/containers.dart/vegetableContainer.dart';
import 'package:adminapp/fertilizer/outlet_create_form.dart';
import 'package:adminapp/fertilizer/outleteview.dart';
import 'package:adminapp/services/outlet_fert_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FertilizerOutlet extends StatefulWidget {
  const FertilizerOutlet({super.key});

  @override
  State<FertilizerOutlet> createState() => _FertilizerOutletState();
}

final FertilizerOutletDatabaseServices _fertilizerOutletService =
    FertilizerOutletDatabaseServices();

class _FertilizerOutletState extends State<FertilizerOutlet> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    void _showAlertDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Create a new fertilizer outlet.'),
          content: FertilizerOutletForm(), // Ensure this is defined elsewhere
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Fertilizer Outlet Details'),
      ),
      // backgroundColor: ColorPalette.forest_Green.withOpacity(0.2),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Gtext(
                        text: "Create a new outlet",
                        size: 20,
                        color: Colors.black,
                        fweight: FontWeight.bold,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showAlertDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // Rounded corners
                          ),
                        ),
                        child: Gtext(
                          text: "Add",
                          size: 16,
                          color: Colors.black,
                          fweight: FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(child: OutletView())
                ],
              ),
            ),
            // 2nd column
            Expanded(
              flex: 6,
              child: Container(
                child: Column(
                  children: [
                    //vege containers
                    Container(
                        height: height * 1 / 2,
                        child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                const Gtext(
                                    text: 'Fertilizer Available Stock (weight/kg)',
                                    size: 25,
                                    color: Colors.black,
                                    fweight: FontWeight.w600),
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 55, right: 55),
                                    child: Container(
                                      // width: width * 0.6,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        // color: Colors.amber,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                                width: 200,
                                                child: Gtext(
                                                    text: "Outlet Number",
                                                    size: 18,
                                                    color: Colors.black,
                                                    fweight: FontWeight.w600)),
                                            Gtext(
                                                text: "TSP",
                                                size: 16,
                                                color: Colors.black,
                                                fweight: FontWeight.w400),
                                            Gtext(
                                                text: "Veg. Fert",
                                                size: 16,
                                                color: Colors.black,
                                                fweight: FontWeight.w400),
                                            Gtext(
                                                text: "Dolomite",
                                                size: 16,
                                                color: Colors.black,
                                                fweight: FontWeight.w400),
                                            Gtext(
                                                text: "MOP",
                                                size: 16,
                                                color: Colors.black,
                                                fweight: FontWeight.w400),
                                            Gtext(
                                                text: "KIE",
                                                size: 16,
                                                color: Colors.black,
                                                fweight: FontWeight.w400),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                                SizedBox(
                                    width: width,
                                    height: height,
                                    child: VegetableContainer()),
                              ],
                            )))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
