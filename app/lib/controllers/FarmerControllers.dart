import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class FarmerControllers extends GetxController {
  static FarmerControllers get instantce => Get.find();

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
}
