import 'package:adminapp/Validations/validator.dart';
import 'package:adminapp/components/Colorpallet.dart';
import 'package:adminapp/components/Gtext.dart';
import 'package:adminapp/components/textfiels.dart';
import 'package:adminapp/controllers/FarmerControllers.dart';
import 'package:adminapp/models/FarmerDetailmodel.dart';
import 'package:adminapp/services/farmer_db_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/instance_manager.dart';

class Drawerr extends StatefulWidget {
  final Function? onpressed;
  const Drawerr({super.key, this.onpressed});

  @override
  State<Drawerr> createState() => _DrawerrState();
}

class _DrawerrState extends State<Drawerr> {
  final contoller = Get.put(FarmerControllers());

  //add database
  final FarmerDatabaseServices _farmerDatabaseServices =
      FarmerDatabaseServices();

  late Farmer? selectedFarmer;
  late bool isEditing;

  @override
  void initState() {
    super.initState();
    selectedFarmer =
        null; // Initialize selectedFarmer as null for new registration
    isEditing = false; // Set isEditing to false for new registration
  }

  Future<void> signUp() async {
    try {
      // Validate form inputs
      if (!formKey.currentState!.validate()) {
        return;
      }

      // Create or update user based on isEditing flag
      if (!isEditing) {
        // Create new user
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: contoller.emailControoler.text.trim(),
                password: contoller.passwordControoler.text.trim());

        // FirebaseFirestore.instance
        //     .collection("Farmers")
        //     .doc(userCredential.user!.email)
        //     .set('uid': User.uid).;

        // Add farmer details to Firestore
        if (userCredential.user != null) {
          Farmer farmer = Farmer(
            firstname: contoller.firstnameControoler.text,
            lastname: contoller.lastnameControoler.text,
            username: contoller.usernameControoler.text,
            age: int.tryParse(contoller.ageContoller.text) ?? 0,
            district: contoller.districtControoler.text,
            address: contoller.addressControoler.text,
            nic: contoller.nicControoler.text,
            email: contoller.emailControoler.text,
            phonenum: int.tryParse(contoller.phonenumController.text) ?? 0,
            passsword: contoller.passwordControoler.text,
            vegetable: contoller.vegetableControoler.text,
            garea: int.tryParse(contoller.gareaController.text) ?? 0,
            honetime: int.tryParse(contoller.honetimeController.text) ?? 0,
            season: contoller.seasonControoler.text,
            price1kg: int.tryParse(contoller.price1kgController.text) ?? 0,
            profit1kg: int.tryParse(contoller.profit1kgController.text) ?? 0,
          );

          // ignore: await_only_futures
          _farmerDatabaseServices.addfarmer(farmer);

          Fluttertoast.showToast(msg: 'User registered successfully!');
          Navigator.pop(context); // Close the drawer
        }
      } else {
        // Update existing user details
        if (selectedFarmer != Farmer) {
          selectedFarmer!.firstname = contoller.firstnameControoler.text;
          selectedFarmer!.lastname = contoller.lastnameControoler.text;
          selectedFarmer!.username = contoller.usernameControoler.text;
          selectedFarmer!.age = int.tryParse(contoller.ageContoller.text) ?? 0;
          selectedFarmer!.district = contoller.districtControoler.text;
          selectedFarmer!.address = contoller.addressControoler.text;
          selectedFarmer!.nic = contoller.nicControoler.text;
          selectedFarmer!.email = contoller.emailControoler.text;
          selectedFarmer!.phonenum =
              int.tryParse(contoller.phonenumController.text) ?? 0;
          selectedFarmer!.passsword = contoller.passwordControoler.text;
          selectedFarmer!.vegetable = contoller.vegetableControoler.text;
          selectedFarmer!.garea =
              int.tryParse(contoller.gareaController.text) ?? 0;
          selectedFarmer!.honetime =
              int.tryParse(contoller.honetimeController.text) ?? 0;
          selectedFarmer!.season = contoller.seasonControoler.text;
          selectedFarmer!.price1kg =
              int.tryParse(contoller.price1kgController.text) ?? 0;
          selectedFarmer!.profit1kg =
              int.tryParse(contoller.profit1kgController.text) ?? 0;

          // _farmerDatabaseServices.updatefarmer(!selectedFarmer);

          Fluttertoast.showToast(msg: 'User details updated successfully!');
          Navigator.pop(context); // Close the drawer
        }
      }
    } catch (e) {
      print('Error occurred during registration: $e');
      Fluttertoast.showToast(msg: 'Registration failed. Please try again.');
    }
  }

  final formKey = GlobalKey<FormState>();

  // Future addUserDetails() async{
  //   await FirebaseFirestore.instance.collection('farmer').
  // }

  @override
  Widget build(BuildContext context) {
    //add database
    final FarmerDatabaseServices farmerDatabaseServices =
        FarmerDatabaseServices();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return StreamBuilder(
        stream: _farmerDatabaseServices.getfarmers(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          List farmers = snapshot.data?.docs ?? [];

          return Drawer(
              width: width * 1 / 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.04,
                        child: const Center(
                          child: Gtext(
                              text: 'Register A New Farmer',
                              size: 18,
                              color: ColorPalette.appBar_color,
                              fweight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: height * 1,
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //first Row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Textfields(
                                      label: 'First name',
                                      icon: const Icon(Icons.person),
                                      tcontroller:
                                          contoller.firstnameControoler,
                                      validator: (value) =>
                                          Validator.validateEmptyText(
                                              'First name', value),
                                      keyboardType: TextInputType.name),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Textfields(
                                      label: 'Last Name',
                                      icon: const Icon(Icons.person),
                                      tcontroller: contoller.lastnameControoler,
                                      validator: (value) =>
                                          Validator.validateEmptyText(
                                            'Last Name',
                                            value,
                                          ),
                                      keyboardType: TextInputType.name)
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              //username
                              Textfields(
                                label: 'User name',
                                icon: const Icon(Icons.person_2_rounded),
                                tcontroller: contoller.usernameControoler,
                                validator: (value) =>
                                    Validator.validateEmptyText(
                                        'User name', value),
                                keyboardType: TextInputType.name,
                              ),

                              //Age
                              Textfields(
                                label: 'Age',
                                icon: const Icon(Icons.info),
                                tcontroller: contoller.ageContoller,
                                validator: (value) =>
                                    Validator.validateEmptyText('Age', value),
                                keyboardType: TextInputType.number,
                              ),

                              //district
                              Textfields(
                                label: 'District',
                                icon: const Icon(Icons.landscape),
                                tcontroller: contoller.districtControoler,
                                validator: (value) =>
                                    Validator.validateEmptyText(
                                        'District', value),
                                keyboardType: TextInputType.text,
                              ),

                              //village
                              Textfields(
                                  label: 'Address',
                                  icon: const Icon(Icons.landscape),
                                  tcontroller: contoller.addressControoler,
                                  validator: (value) =>
                                      Validator.validateEmptyText(
                                          'address', value),
                                  keyboardType: TextInputType.text),

                              //nic
                              Textfields(
                                  label: 'NIC',
                                  icon: const Icon(Icons.credit_card),
                                  tcontroller: contoller.nicControoler,
                                  validator: (value) =>
                                      Validator.validateEmptyText('NIC', value),
                                  keyboardType: TextInputType.text),

                              //email
                              Textfields(
                                  label: 'Email',
                                  icon: const Icon(Icons.email_outlined),
                                  tcontroller: contoller.emailControoler,
                                  validator: (value) =>
                                      Validator.validatorEmail(value),
                                  keyboardType: TextInputType.text),

                              //phone num
                              Textfields(
                                  label: 'Phone number',
                                  icon: const Icon(Icons.call_end_outlined),
                                  tcontroller: contoller.phonenumController,
                                  validator: (value) =>
                                      Validator.validateEmptyText(
                                          'Phone Number', value),
                                  keyboardType: TextInputType.number),
                              //password
                              Textfields(
                                  label: 'password',
                                  icon: const Icon(Icons.password_sharp),
                                  tcontroller: contoller.passwordControoler,
                                  validator: (value) =>
                                      Validator.validationPassword(value),
                                  keyboardType: TextInputType.text),

                              //this should be a drop down

                              SizedBox(
                                height: height * 0.04,
                                child: const Center(
                                  child: Gtext(
                                      text: 'Harvest Details',
                                      size: 18,
                                      color: ColorPalette.appBar_color,
                                      fweight: FontWeight.w500),
                                ),
                              ),
                              Textfields(
                                  label: 'Vegetable',
                                  icon: const Icon(Icons.local_florist),
                                  tcontroller: contoller.vegetableControoler,
                                  validator: (value) =>
                                      Validator.validateEmptyText(
                                          'Vegetable', value),
                                  keyboardType: TextInputType.text),

                              //Area
                              Textfields(
                                  label: 'Growing Area (km2)',
                                  icon: const Icon(Icons.area_chart),
                                  tcontroller: contoller.gareaController,
                                  validator: (value) =>
                                      Validator.validateEmptyText(
                                          'Area', value),
                                  keyboardType: TextInputType.number),

                              //Harvest for one time (kg)
                              Textfields(
                                  label: 'Harvest for one time (kg)',
                                  icon: const Icon(Icons.price_change_outlined),
                                  tcontroller: contoller.honetimeController,
                                  validator: (value) =>
                                      Validator.validateEmptyText(
                                          'Harvest', value),
                                  keyboardType: TextInputType.number),

                              //Area
                              Textfields(
                                  label: 'Season (time range)',
                                  icon: const Icon(Icons.watch),
                                  tcontroller: contoller.seasonControoler,
                                  validator: (value) =>
                                      Validator.validateEmptyText(
                                          'Season', value),
                                  keyboardType: TextInputType.text),

                              //Area
                              Textfields(
                                  label: 'Price for per 1kg',
                                  icon: const Icon(Icons.price_check),
                                  tcontroller: contoller.price1kgController,
                                  validator: (value) =>
                                      Validator.validateEmptyText(
                                          'price', value),
                                  keyboardType: TextInputType.number),

                              //Area
                              Textfields(
                                  label: 'Profit for per 1kg',
                                  icon: const Icon(Icons.price_change),
                                  tcontroller: contoller.profit1kgController,
                                  validator: (value) =>
                                      Validator.validateEmptyText(
                                          'profit', value),
                                  keyboardType: TextInputType.number),

                              //Button
                              Center(
                                child: SizedBox(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //Register button
                                      MaterialButton(
                                        color: ColorPalette.button_color,
                                        onPressed: signUp,
                                        child: const Gtext(
                                            text: 'Register',
                                            size: 15,
                                            color: ColorPalette.appBar_color,
                                            fweight: FontWeight.w500),
                                      ),

                                      //cancel button
                                      MaterialButton(
                                        color: ColorPalette.button_color,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Gtext(
                                            text: 'Cancel',
                                            size: 15,
                                            color: ColorPalette.red,
                                            fweight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
