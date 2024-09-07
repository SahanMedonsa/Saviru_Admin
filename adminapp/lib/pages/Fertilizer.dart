import 'package:adminapp/components/Colorpallet.dart';
import 'package:adminapp/components/Drawer.dart';
import 'package:adminapp/components/Gtext.dart';
import 'package:adminapp/containers.dart/choosefertilzer.dart';
import 'package:adminapp/containers.dart/fertilizerstockcard.dart';
import 'package:adminapp/containers.dart/nextseasonfertilizeramount.dart';
import 'package:adminapp/containers.dart/vegetableContainer.dart';
import 'package:flutter/material.dart';

class Fertilizer extends StatefulWidget {
  const Fertilizer({super.key});

  @override
  State<Fertilizer> createState() => _FertilizerState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _FertilizerState extends State<Fertilizer> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorPalette.Jungle_Green.withOpacity(0.2),
      endDrawer: Drawerr(),
      body: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                children: [
                  Container(
                    height: height ,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Gtext(
                            text: 'Choose Best Fertilizer ',
                            size: 25,
                            color: Colors.black,
                            fweight: FontWeight.w600),
                        SizedBox(
                          height: 10,
                        ),
                        chooseBestfertilzer()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 8,
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
                                  text: 'Fertilizer Availbel Stock',
                                  size: 25,
                                  color: Colors.black,
                                  fweight: FontWeight.w600),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20, left: 55, right: 55),
                                  child: Container(
                                    // width: width * 0.6,
                                    height: 40,
                                    decoration: BoxDecoration(
                                     // color: Colors.amber,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: const Row(
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
                                width: width 
                                ,
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
    );
  }
}
