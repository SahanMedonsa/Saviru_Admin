import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class BlogControllers extends GetxController {
  static BlogControllers get instantce => Get.find();

  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  final DescriptionController = TextEditingController();
}
