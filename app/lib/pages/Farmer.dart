import 'dart:html';

import 'package:app/Farmer/FarmerCard.dart';
import 'package:app/Farmer/detail_row.dart';
import 'package:app/Farmer/harvest_detail.dart';
import 'package:app/Farmer/personal_detail.dart';
import 'package:app/components/DetailContainer.dart';
import 'package:app/components/Drawer.dart';
import 'package:app/components/Gtext.dart';
import 'package:app/components/colorPallet.dart';
import 'package:app/models/FarmerDetailmodel.dart';
import 'package:app/pages/FarmerDetails.dart';
import 'package:app/services/farmer_db_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FarmerPage extends StatefulWidget {
  const FarmerPage({super.key});

  @override
  State<FarmerPage> createState() => _FarmerPageState();
}

class _FarmerPageState extends State<FarmerPage> {
  // Add a GlobalKey for the Scaffold to control the drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  // Add a variable to store the selected farmer ID
  String? selectedFarmerId;

  // Add a method to open the drawer and reload the farmers list
  void _openDrawerAndReload() {
    Scaffold.of(context).openEndDrawer();
    setState(() {});
  }

  //add database
  final FarmerDatabaseServices _farmerDatabaseServices =
      FarmerDatabaseServices();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          endDrawer: const Drawerr(),
          body: Padding(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.03, horizontal: width * 0.03),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Gtext(
                          text: 'Farmer Details',
                          size: 20,
                          color: ColorPalette.appBar_color,
                          fweight: FontWeight.bold)
                    ],
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Gtext(
                            text: 'Register a New Farmer',
                            size: 18,
                            color: ColorPalette.appBar_color,
                            fweight: FontWeight.w500),
                        Builder(builder: (context) {
                          return MaterialButton(
                            color: ColorPalette.button_color,
                            onPressed: () {
                              Scaffold.of(context).openEndDrawer();
                            },
                            child: const Gtext(
                                text: 'Add',
                                size: 15,
                                color: ColorPalette.appBar_color,
                                fweight: FontWeight.w500),
                          );
                        })
                      ],
                    ),
                  ),

                  //stream builder
                  SizedBox(
                    height: height * 0.05,
                  ),
                  SizedBox(
                    // color: Colors.red,
                    width: width * 1,

                    child: StreamBuilder(
                      stream: _farmerDatabaseServices.getfarmers(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        List farmers = snapshot.data?.docs ?? [];

                        if (farmers.isEmpty) {
                          return const Center(child: Text('Add Farmers'));
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  DetailContainer(
                                      Cicon: Icons.person,
                                      ctext: "Registered Farmers",
                                      count: farmers.length.toString(),
                                      Ccolor: ColorPalette.Jungle_Green),
                                  SizedBox(
                                    // color: Colors.red,
                                    width: width * 0.05,
                                  ),
                                  DetailContainer(
                                      Cicon: Icons.person,
                                      ctext: "Registered Farmers",
                                      count: farmers.length.toString(),
                                      Ccolor: ColorPalette.Jungle_Green),
                                  SizedBox(
                                    // color: Colors.red,
                                    width: width * 0.05,
                                  ),
                                  DetailContainer(
                                      Cicon: Icons.person,
                                      ctext: "Registered Farmers",
                                      count: farmers.length.toString(),
                                      Ccolor: ColorPalette.Jungle_Green),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            //////////////farmers detail///////////////
                            SizedBox(
                              //     color: Colors.green,
                              width: width * 1,
                              height: height * 0.7,
                              child: ListView.builder(
                                itemCount: farmers.length,
                                itemBuilder: (context, index) {
                                  Farmer farmer = farmers[index].data();
                                  String farmerId = farmers[index].id;
                                  print(farmerId);

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      child: ExpansionTile(
                                        title: Gtext(
                                            text: farmer.firstname +
                                                " " +
                                                farmer.lastname,
                                            size: 15,
                                            color: ColorPalette.Jungle_Green,
                                            fweight: FontWeight.w400),
                                        children: [
                                          Container(
                                            height: 350,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      //Personal details
                                                      personalDetails(
                                                          fullname: farmer
                                                                  .firstname +
                                                              " " +
                                                              farmer.lastname,
                                                          username:
                                                              farmer.username,
                                                          age: farmer.age
                                                              .toString(),
                                                          district:
                                                              farmer.district,
                                                          address:
                                                              farmer.address,
                                                          nic: farmer.nic,
                                                          email: farmer.email,
                                                          phonenum: farmer
                                                              .phonenum
                                                              .toString()),

                                                      //Harvest Details
                                                      harvestdetails(
                                                          vegetable:
                                                              farmer.vegetable,
                                                          garea: farmer.garea
                                                              .toString(),
                                                          honetime: farmer
                                                              .honetime
                                                              .toString(),
                                                          season: farmer.season,
                                                          price1kg: farmer
                                                              .price1kg
                                                              .toString(),
                                                          profit1kg: farmer
                                                              .profit1kg
                                                              .toString()),
                                                      //Income Details
                                                      Container(
                                                        width: width / 4,
                                                        //  color: Colors.black,
                                                        child: Column(
                                                          children: [
                                                            Gtextn(
                                                                text:
                                                                    'Income Details'),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    height: 50,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {},
                                                            icon: Icon(
                                                              Icons.edit,
                                                              size: 30,
                                                              color: ColorPalette
                                                                  .appBar_color,
                                                            )),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        IconButton(
                                                            onPressed: () {
                                                              _farmerDatabaseServices
                                                                  .deletefarmer(
                                                                      farmerId);
                                                            },
                                                            icon: Icon(
                                                              Icons.delete,
                                                              size: 30,
                                                              color:
                                                                  ColorPalette
                                                                      .red,
                                                            )),
                                                        SizedBox(
                                                          width: 30,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                        return CircularProgressIndicator();
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
