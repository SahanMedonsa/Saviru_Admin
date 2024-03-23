import 'package:app/Validations/validator.dart';
import 'package:app/components/Gtext.dart';
import 'package:app/components/colorPallet.dart';
import 'package:app/components/textfiels.dart';
import 'package:app/models/FarmerDetailmodel.dart';
import 'package:app/services/farmer_db_service.dart';
import 'package:flutter/material.dart';

class Drawerr extends StatefulWidget {
  const Drawerr({super.key});

  @override
  State<Drawerr> createState() => _DrawerrState();
}

class _DrawerrState extends State<Drawerr> {
  final firstnameControoler = TextEditingController();
  final lastnameControoler = TextEditingController();
  final usernameControoler = TextEditingController();
  final ageContoller = TextEditingController();

  final nicControoler = TextEditingController();
  final emailControoler = TextEditingController();
  final phonenumController = TextEditingController();

  final passwordControoler = TextEditingController();
  final districtControoler = TextEditingController();
  final addressControoler = TextEditingController();
  final vegetableControoler = TextEditingController();
  final gareaController = TextEditingController();

  final honetimeController = TextEditingController();

  final seasonControoler = TextEditingController();
  final price1kgController = TextEditingController();

  final profit1kgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //add database
    final FarmerDatabaseServices farmerDatabaseServices =
        FarmerDatabaseServices();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final formKey = GlobalKey<FormState>();
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Textfields(
                                label: 'First name',
                                icon: const Icon(Icons.person),
                                tcontroller: firstnameControoler,
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
                                tcontroller: lastnameControoler,
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
                          tcontroller: usernameControoler,
                          validator: (value) =>
                              Validator.validateEmptyText('User name', value),
                          keyboardType: TextInputType.name,
                        ),

                        //Age
                        Textfields(
                          label: 'Age',
                          icon: const Icon(Icons.info),
                          tcontroller: ageContoller,
                          validator: (value) =>
                              Validator.validateEmptyText('Age', value),
                          keyboardType: TextInputType.number,
                        ),

                        //district
                        Textfields(
                          label: 'District',
                          icon: const Icon(Icons.landscape),
                          tcontroller: districtControoler,
                          validator: (value) =>
                              Validator.validateEmptyText('District', value),
                          keyboardType: TextInputType.text,
                        ),

                        //village
                        Textfields(
                            label: 'Address',
                            icon: const Icon(Icons.landscape),
                            tcontroller: addressControoler,
                            validator: (value) =>
                                Validator.validateEmptyText('address', value),
                            keyboardType: TextInputType.text),

                        //nic
                        Textfields(
                            label: 'NIC',
                            icon: const Icon(Icons.credit_card),
                            tcontroller: nicControoler,
                            validator: (value) =>
                                Validator.validateEmptyText('NIC', value),
                            keyboardType: TextInputType.text),

                        //email
                        Textfields(
                            label: 'Email',
                            icon: const Icon(Icons.email_outlined),
                            tcontroller: emailControoler,
                            validator: (value) =>
                                Validator.validatorEmail(value),
                            keyboardType: TextInputType.text),

                        //phone num
                        Textfields(
                            label: 'Phone number',
                            icon: const Icon(Icons.call_end_outlined),
                            tcontroller: phonenumController,
                            validator: (value) => Validator.validateEmptyText(
                                'Phone Number', value),
                            keyboardType: TextInputType.number),
                        //password
                        Textfields(
                            label: 'password',
                            icon: const Icon(Icons.password_sharp),
                            tcontroller: passwordControoler,
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
                            tcontroller: vegetableControoler,
                            validator: (value) =>
                                Validator.validateEmptyText('Vegetable', value),
                            keyboardType: TextInputType.text),

                        //Area
                        Textfields(
                            label: 'Growing Area (km2)',
                            icon: const Icon(Icons.area_chart),
                            tcontroller: gareaController,
                            validator: (value) =>
                                Validator.validateEmptyText('Area', value),
                            keyboardType: TextInputType.number),

                        //Harvest for one time (kg)
                        Textfields(
                            label: 'Harvest for one time (kg)',
                            icon: const Icon(Icons.price_change_outlined),
                            tcontroller: honetimeController,
                            validator: (value) =>
                                Validator.validateEmptyText('Harvest', value),
                            keyboardType: TextInputType.number),

                        //Area
                        Textfields(
                            label: 'Season (time range)',
                            icon: const Icon(Icons.watch),
                            tcontroller: seasonControoler,
                            validator: (value) =>
                                Validator.validateEmptyText('Season', value),
                            keyboardType: TextInputType.text),

                        //Area
                        Textfields(
                            label: 'Price for per 1kg',
                            icon: const Icon(Icons.price_check),
                            tcontroller: price1kgController,
                            validator: (value) =>
                                Validator.validateEmptyText('price', value),
                            keyboardType: TextInputType.number),

                        //Area
                        Textfields(
                            label: 'Profit for per 1kg',
                            icon: const Icon(Icons.price_change),
                            tcontroller: profit1kgController,
                            validator: (value) =>
                                Validator.validateEmptyText('profit', value),
                            keyboardType: TextInputType.number),

                        //Button
                        Center(
                          child: SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Register button
                                MaterialButton(
                                  color: ColorPalette.button_color,
                                  onPressed: () {
                                    int age =
                                        int.tryParse(ageContoller.text) ?? 0;
                                    int phonenum =
                                        int.tryParse(phonenumController.text) ??
                                            0;
                                    int garea =
                                        int.tryParse(gareaController.text) ?? 0;
                                    int honetime =
                                        int.tryParse(honetimeController.text) ??
                                            0;
                                    int price1kg =
                                        int.tryParse(price1kgController.text) ??
                                            0;
                                    int profit1kg = int.tryParse(
                                            profit1kgController.text) ??
                                        0;
                                    if (formKey.currentState!.validate()) {
                                      Farmer farmer = Farmer(
                                          firstname: firstnameControoler.text,
                                          lastname: lastnameControoler.text,
                                          username: usernameControoler.text,
                                          age: age,
                                          district: districtControoler.text,
                                          address: addressControoler.text,
                                          nic: nicControoler.text,
                                          email: emailControoler.text,
                                          phonenum: phonenum,
                                          passsword: passwordControoler.text,
                                          vegetable: vegetableControoler.text,
                                          garea: garea,
                                          honetime: honetime,
                                          season: seasonControoler.text,
                                          price1kg: price1kg,
                                          profit1kg: profit1kg);

                                      farmerDatabaseServices.addfarmer(farmer);
                                      Navigator.pop(context);
                                    }
                                  },
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
  }
}
