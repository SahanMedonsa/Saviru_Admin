import 'dart:math';

import 'package:adminapp/Farmer/detail_row.dart';
import 'package:adminapp/components/Gtext.dart';
import 'package:flutter/material.dart';

class personalDetails extends StatelessWidget {
  final String fullname;

  final String username;
  final String age;
  final String district;
  final String address;
  final String nic;
  final String email;
  final String phonenum;
  final String password;

  const personalDetails(
      {super.key,
      required this.fullname,
      required this.username,
      required this.age,
      required this.district,
      required this.address,
      required this.nic,
      required this.email,
      required this.phonenum,
      required this.password});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width / 4,
      // color: Colors.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gtextn(text: 'Personal Details'),
          const SizedBox(
            height: 10,
          ),
          DetailRow(detail: 'User ID ', fdetail: username),
          DetailRow(detail: 'Full Name  ', fdetail: fullname),
          DetailRow(detail: 'Age ', fdetail: age),
          DetailRow(detail: 'NIC ', fdetail: nic),
          DetailRow(detail: 'Address', fdetail: address),
          DetailRow(detail: 'District ', fdetail: district),
          DetailRow(detail: 'Email ', fdetail: email),
          DetailRow(detail: 'Phone Number', fdetail: phonenum),
          DetailRow(detail: 'Password', fdetail: password)
        ],
      ),
    );
  }
}
