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
            flex: 6,
            child: Container(
              child: Column(
                children: [
                  Container(
                      height: height * 1 / 2,
                      child: nextseasonfertilizerstockcard()),
                  Container(
                    height: height * 1 / 2,
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
            flex: 6,
            child: Container(
              child: Column(
                children: [
                  //vege containers
                  Container(
                    height: height * 1 / 2,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: const Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Gtext(
                              text: 'Vegetables',
                              size: 25,
                              color: Colors.black,
                              fweight: FontWeight.w600),
                          SizedBox(
                            height: 10,
                          ),
                          Center(child: vegetablecontainer())
                        ],
                      ),
                    ),
                  ),
                  Container(
                      height: height * 1 / 2,
                      // color: Colors.green,
                      child: fertilizerstockcard()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
