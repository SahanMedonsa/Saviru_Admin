import 'package:adminapp/IOT/home_page.dart';
import 'package:adminapp/ML/vegetableprdict.dart';
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
                       

                        Gtext(
                            text: 'Choose best vegetable ',
                            size: 25,
                            color: Colors.black,
                            fweight: FontWeight.w600),
                        SizedBox(
                          height: 10,
                        ),
                        
                       VegetablePredictionScreen()

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            flex: 4,
            child: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      height: height ,
                      child: Column(
                        children: [
                          Gtext(
                              text: 'Choose best vegetable ',
                              size: 25,
                              color: Colors.black,
                              fweight: FontWeight.w600),
                          SizedBox(
                            height: 10,
                          ),
                          
                         HomePage()
                
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
         
        ],
      ),
    );
  }
}
