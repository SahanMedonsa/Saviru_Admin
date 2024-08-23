import 'package:cloud_firestore/cloud_firestore.dart';

class FertilizerOutlet {
  String district;
  String outletNo;
  String username;
  String password;
  String manager;
  String address;
  String phoneNum;

  FertilizerOutlet({
    required this.district,
    required this.outletNo,
    required this.username,
    required this.password,
    required this.manager,
    required this.address,
    required this.phoneNum,
  });

  // Convert FertilizerOutlet object to a Map
  Map<String, dynamic> toMap() {
    return {
      'district': district,
      'outletNo': outletNo,
      'username': username,
      'password': password,
      'manager': manager,
      'address': address,
      'phoneNum': phoneNum,
    };
  }

  factory FertilizerOutlet.fromJson(Map<String, dynamic> json) {
    return FertilizerOutlet(
      district: json['district'] as String? ?? '',
      outletNo: json['outletNo'] as String? ?? '',
      username: json['username'] as String? ?? '',
      password: json['password'] as String? ?? '',
      manager: json['manager'] as String? ?? '',
      address: json['address'] as String? ?? '',
      phoneNum: json['phoneNum'] as String? ?? '',
    );
  }

  FertilizerOutlet copyWith({
    String? district,
    String? outletNo,
    String? username,
    String? password,
    String? manager,
    String? address,
    String? phoneNum,
  }) {
    return FertilizerOutlet(
      district: district ?? this.district,
      outletNo: outletNo ?? this.outletNo,
      username: username ?? this.username,
      password: password ?? this.password,
      manager: manager ?? this.manager,
      address: address ?? this.address,
      phoneNum: phoneNum ?? this.phoneNum,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'district': district,
      'outletNo': outletNo,
      'username': username,
      'password': password,
      'manager': manager,
      'address': address,
      'phoneNum': phoneNum,
    };
  }
}
