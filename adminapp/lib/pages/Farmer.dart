import 'package:adminapp/Farmer/harvest_detail.dart';
import 'package:adminapp/Farmer/personal_detail.dart';
import 'package:adminapp/components/Colorpallet.dart';
import 'package:adminapp/components/DetailContainer.dart';
import 'package:adminapp/components/Drawer.dart';
import 'package:adminapp/components/Gtext.dart';
import 'package:adminapp/controllers/FarmerControllers.dart';
import 'package:adminapp/models/FarmerDetailmodel.dart';
import 'package:adminapp/pages/FarmerDetails.dart';
import 'package:adminapp/services/farmer_db_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:pie_chart/pie_chart.dart';

class FarmerPage extends StatefulWidget {
  const FarmerPage({super.key});

  @override
  State<FarmerPage> createState() => _FarmerPageState();
}

class _FarmerPageState extends State<FarmerPage> {
  Map<String, double> datamap = {
    "Carrot": 10,
    "Cabbage": 15,
    "Capsicum": 12,
    "Beans": 15,
    "Potato": 18
  };
  final contoller = Get.put(FarmerControllers());
  // Add a GlobalKey for the Scaffold to control the drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  // Add a variable to store the selected farmer ID
  String? selectedFarmerId;

  // Add a method to open the drawer and reload the farmers list

  //add database
  final FarmerDatabaseServices _farmerDatabaseServices =
      FarmerDatabaseServices();

  TextEditingController search_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(width);
    print(height);
    return ScreenUtilInit(
      designSize: Size(360, 690),
      child: SafeArea(
        child: Scaffold(
            backgroundColor: ColorPalette.Emerald_Green.withOpacity(0.2),
            endDrawer: const Drawerr(),
            body: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.03, horizontal: width * 0.03),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
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
                            height: height * 0.03,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            controller: search_controller,
                            decoration: InputDecoration(
                              prefixIconColor: ColorPalette.appBar_color,

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(13),
                                  borderSide: BorderSide(
                                      color: ColorPalette.appBar_color)),
                              hintText:
                                  'Search', // Use labelText instead of label

                              // Assuming TextStyles.smallText is defined
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
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

                          //////////////stream builder////////////////////
                          /////////////////stream builder/////////////////
                          /////////////////stream builder/////////////////
                          SizedBox(
                            height: height * 0.05,
                          ),
                          SizedBox(
                            // color: Colors.red,
                            // width: width * 1 / 2,
                            // height: 600,

                            child: StreamBuilder(
                              stream: _farmerDatabaseServices.getfarmers(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                List farmers = snapshot.data?.docs ?? [];

                                if (farmers.isEmpty) {
                                  return const Center(
                                      child: Text('Add Farmers'));
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
                                              Ccolor:
                                                  ColorPalette.Jungle_Green),
                                          SizedBox(
                                            // color: Colors.red,
                                            width: 100,
                                          ),
                                          FarmerDetailsPage(),
                                          SizedBox(
                                            // color: Colors.red,
                                            width: 100,
                                          ),
                                          // DetailContainer(
                                          //     Cicon: Icons.person,
                                          //     ctext: "Registered Farmers",
                                          //     count: farmers.length.toString(),
                                          //     Ccolor:
                                          //         ColorPalette.Jungle_Green),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    //////////////farmers detail///////////////
                                    SizedBox(
                                      //     color: Colors.green,

                                      height: height * 0.8,
                                      child: ListView.builder(
                                        itemCount: farmers.length,
                                        itemBuilder: (context, index) {
                                          Farmer farmer = farmers[index].data();
                                          String farmerId = farmers[index].id;
                                          // print(farmerId);

                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Card(
                                              child: ExpansionTile(
                                                title: Gtext(
                                                    text: farmer.firstname +
                                                        " " +
                                                        farmer.lastname,
                                                    size: 15,
                                                    color: ColorPalette
                                                        .Jungle_Green,
                                                    fweight: FontWeight.w400),
                                                children: [
                                                  Container(
                                                    height: 400,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Column(
                                                        children: [
                                                          SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            child: Row(
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
                                                                      farmer
                                                                          .lastname,
                                                                  username: farmer
                                                                      .username,
                                                                  age: farmer
                                                                      .age
                                                                      .toString(),
                                                                  district: farmer
                                                                      .district,
                                                                  address: farmer
                                                                      .address,
                                                                  nic: farmer
                                                                      .nic,
                                                                  email: farmer
                                                                      .email,
                                                                  phonenum: farmer
                                                                      .phonenum
                                                                      .toString(),
                                                                  password: farmer
                                                                      .passsword,
                                                                ),

                                                                //Harvest Details
                                                                harvestdetails(
                                                                    vegetable:
                                                                        farmer
                                                                            .vegetable,
                                                                    garea: farmer
                                                                        .garea
                                                                        .toString(),
                                                                    honetime: farmer
                                                                        .honetime
                                                                        .toString(),
                                                                    season: farmer
                                                                        .season,
                                                                    price1kg: farmer
                                                                        .price1kg
                                                                        .toString(),
                                                                    profit1kg: farmer
                                                                        .profit1kg
                                                                        .toString()),
                                                                //Income Details
                                                                Container(
                                                                  width:
                                                                      width / 4,
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
                                                          ),
                                                          Container(
                                                            height: 50,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      // Set controller values with selected farmer details
                                                                      contoller
                                                                              .firstnameControoler
                                                                              .text =
                                                                          farmer
                                                                              .firstname;
                                                                      contoller
                                                                              .lastnameControoler
                                                                              .text =
                                                                          farmer
                                                                              .lastname;
                                                                      contoller
                                                                              .usernameControoler
                                                                              .text =
                                                                          farmer
                                                                              .username;
                                                                      contoller
                                                                              .ageContoller
                                                                              .text =
                                                                          farmer
                                                                              .age
                                                                              .toString();
                                                                      contoller
                                                                              .districtControoler
                                                                              .text =
                                                                          farmer
                                                                              .district;
                                                                      contoller
                                                                              .addressControoler
                                                                              .text =
                                                                          farmer
                                                                              .address;
                                                                      contoller
                                                                              .nicControoler
                                                                              .text =
                                                                          farmer
                                                                              .nic;
                                                                      contoller
                                                                              .emailControoler
                                                                              .text =
                                                                          farmer
                                                                              .email;
                                                                      contoller
                                                                              .phonenumController
                                                                              .text =
                                                                          farmer
                                                                              .phonenum
                                                                              .toString();
                                                                      contoller
                                                                              .vegetableControoler
                                                                              .text =
                                                                          farmer
                                                                              .vegetable;
                                                                      contoller
                                                                              .gareaController
                                                                              .text =
                                                                          farmer
                                                                              .garea
                                                                              .toString();
                                                                      contoller
                                                                              .honetimeController
                                                                              .text =
                                                                          farmer
                                                                              .honetime
                                                                              .toString();
                                                                      contoller
                                                                              .seasonControoler
                                                                              .text =
                                                                          farmer
                                                                              .season;
                                                                      contoller
                                                                              .price1kgController
                                                                              .text =
                                                                          farmer
                                                                              .price1kg
                                                                              .toString();
                                                                      contoller
                                                                              .profit1kgController
                                                                              .text =
                                                                          farmer
                                                                              .profit1kg
                                                                              .toString();
                                                                      contoller
                                                                              .passwordControoler
                                                                              .text =
                                                                          farmer
                                                                              .passsword
                                                                              .toString();

                                                                      // Open end drawer
                                                                      Scaffold.of(
                                                                              context)
                                                                          .openEndDrawer();
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .edit,
                                                                      size: 30,
                                                                      color: ColorPalette
                                                                          .appBar_color,
                                                                    )),
                                                                const SizedBox(
                                                                  width: 20,
                                                                ),
                                                                IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      _farmerDatabaseServices
                                                                          .deletefarmer(
                                                                              farmerId);
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .delete,
                                                                      size: 30,
                                                                      color: ColorPalette
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
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                        width: width * 1 / 2.9,
                        height: height,
                        //color: Colors.red,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Gtextn(text: "Percentage of Vegetable Grow "),
                              SizedBox(
                                height: 30,
                              ),
                              PieChart(
                                dataMap: datamap,
                                chartRadius: width * 1 / 6,
                                chartValuesOptions: ChartValuesOptions(
                                    showChartValuesInPercentage: true,
                                    showChartValues: true),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Gtextn(
                                  text:
                                      "Farmer Price Calculations ( 01 acres) "),
                              Container(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    DropdownButtonFormField<String>(
                                      value: _selectedDistrict,
                                      items: [
                                        'Carrot',
                                        'Cabbage',
                                        'Potato',
                                        'Beans',
                                        'Capcicum'
                                      ]
                                          .map((district) =>
                                              DropdownMenuItem<String>(
                                                value: district,
                                                child: Text(district),
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedDistrict = value ??
                                              'Kalutara'; // Default to Kalutara if null
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Select Vegetable',
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    TextField(
                                      controller: _carrotController,
                                      decoration: const InputDecoration(
                                          labelText: 'Pre Workers Cost :'),
                                      keyboardType: TextInputType.number,
                                    ),
                                    const SizedBox(height: 20.0),
                                    TextField(
                                      controller: _potatoController,
                                      decoration: const InputDecoration(
                                          labelText: 'Seeds price :'),
                                      keyboardType: TextInputType.number,
                                    ),
                                    const SizedBox(height: 20.0),
                                    TextField(
                                      controller: _cabbageController,
                                      decoration: const InputDecoration(
                                          labelText: 'Fertilizer Cost :'),
                                      keyboardType: TextInputType.number,
                                    ),
                                    const SizedBox(height: 20.0),
                                    TextField(
                                      controller: _capsicumController,
                                      decoration: const InputDecoration(
                                          labelText: 'Insecticides Cost'),
                                      keyboardType: TextInputType.number,
                                    ),
                                    const SizedBox(height: 20.0),
                                    TextField(
                                      controller: _beansController,
                                      decoration: const InputDecoration(
                                          labelText: 'Transport cost'),
                                      keyboardType: TextInputType.number,
                                    ),
                                    SizedBox(height: 40.0),
                                    ElevatedButton(
                                      onPressed: _submitForm,
                                      child: Text('Submit'),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  )
                ],
              ),
            )),
      ),
    );
  }

  late TextEditingController _carrotController;
  late TextEditingController _potatoController;
  late TextEditingController _cabbageController;
  late TextEditingController _capsicumController;
  late TextEditingController _beansController;

  String _selectedDistrict = 'Carrot'; // Default selected district

  @override
  void initState() {
    super.initState();
    _carrotController = TextEditingController();
    _potatoController = TextEditingController();
    _cabbageController = TextEditingController();
    _capsicumController = TextEditingController();
    _beansController = TextEditingController();
  }

  @override
  void dispose() {
    _carrotController.dispose();
    _potatoController.dispose();
    _cabbageController.dispose();
    _capsicumController.dispose();
    _beansController.dispose();
    super.dispose();
  }

  void _submitForm() {
    // Handle form submission here (e.g., save data to Firestore)
    // Clear text field values after submission
    _carrotController.clear();
    _potatoController.clear();
    _cabbageController.clear();
    _capsicumController.clear();
    _beansController.clear();
    setState(() {
      _selectedDistrict = 'Carrot'; // Reset district dropdown to default
    });
    // Show a dialog or perform further actions after submission
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Price Generated'),
        content: Text('Carrote cost : 45/-'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
