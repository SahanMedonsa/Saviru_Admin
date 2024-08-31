import 'package:adminapp/components/textfiels.dart';
import 'package:adminapp/models/fertilize_outlet_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Assume you have a service class similar to FarmerDatabaseServices for fertilizer outlets
class FertilizerOutletDatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = "fertilizer"; // Specified collection name

  Future<void> addOutlet(FertilizerOutlet outlet) async {
    await _firestore.collection(collectionName).add(outlet.toJson());
  }

  

  
}

class FertilizerOutletForm extends StatefulWidget {
  const FertilizerOutletForm({Key? key}) : super(key: key);

  @override
  State<FertilizerOutletForm> createState() => _FertilizerOutletFormState();
}

class _FertilizerOutletFormState extends State<FertilizerOutletForm> {
  final TextEditingController districtController = TextEditingController();
  final TextEditingController outletNoController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController managerController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final FertilizerOutletDatabaseService _databaseServices = FertilizerOutletDatabaseService();

  bool isEditing = false; // Add flag for editing mode
  FertilizerOutlet? selectedOutlet; // For updating, if applicable

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;

    return Container(
      width: width * 1/3,
      height: height * 1/2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Textfields(
                label: 'District',
                tcontroller: districtController,
                keyboardType: TextInputType.text,
              ),
                   SizedBox(height: 10),
              Textfields(
                label: 'Outlet No',
                tcontroller: outletNoController,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 10),
              Textfields(
                label: 'Username',
                tcontroller: usernameController,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 10),
              Textfields(
                label: 'Password',
                tcontroller: passwordController,
                keyboardType: TextInputType.text,
                validator: (value) => value == null || value.isEmpty ? 'Enter password' : null,
              ),
              SizedBox(height: 10),
              Textfields(
                label: 'Manager',
                tcontroller: managerController,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 10),
              Textfields(
                label: 'Address',
                tcontroller: addressController,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 10),
              Textfields(
                label: 'Phone Number',
                tcontroller: phoneNumController,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: _showCancelDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signUp() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      if (!isEditing) {
          UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: usernameController.text.trim(),
                password: passwordController.text.trim());

        // Create new outlet
        FertilizerOutlet outlet = FertilizerOutlet(
          district: districtController.text.trim(),
          outletNo: outletNoController.text.trim(),
          username: usernameController.text.trim(),
          password: passwordController.text.trim(),
          manager: managerController.text.trim(),
          address: addressController.text.trim(),
          phoneNum: phoneNumController.text.trim(),
        );

        await _databaseServices.addOutlet(outlet);
        Fluttertoast.showToast(msg: 'Outlet registered successfully!');
        Navigator.pop(context);
      } else {
        // Update existing outlet, implement as needed
        selectedOutlet!.district = districtController.text.trim();
        // Update other fields similarly...
        Fluttertoast.showToast(msg: 'Outlet details updated successfully!');
        Navigator.pop(context);
      }
    } catch (e) {
      print('Error occurred: $e');
      Fluttertoast.showToast(msg: 'Operation failed. Please try again.');
    }
  }

  void _submitForm() {
    signUp();
  }

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cancel'),
        content: Text('Are you sure you want to cancel?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('No'),
          ),
        ],
      ),
    );
  }
}
