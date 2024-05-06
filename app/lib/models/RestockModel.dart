import 'package:cloud_firestore/cloud_firestore.dart';

class Restock {
  int carrotAmount;
  int potatoAmount;
  int cabbageAmount;
  int capsicumAmount;
  int beansAmount;
  String disCode;
  Timestamp requestDate;
  String district;

  Restock(
      {required this.carrotAmount,
      required this.potatoAmount,
      required this.cabbageAmount,
      required this.capsicumAmount,
      required this.beansAmount,
      required this.disCode,
      required this.requestDate,
      required this.district});

  // Method to convert Restock object to a Map (JSON format)
  Map<String, dynamic> toMap() {
    return {
      'carrot': carrotAmount,
      'potato': potatoAmount,
      'cabbage': cabbageAmount,
      'capsicum': capsicumAmount,
      'beans': beansAmount,
      'disCode': disCode,
      'requestdate': requestDate,
      'district': district,
    };
  }

  // Factory constructor to create a Restock object from a JSON map
  factory Restock.fromJson(Map<String, dynamic> json) {
    return Restock(
        carrotAmount: json['carrot'] as int? ?? 0,
        potatoAmount: json['potato'] as int? ?? 0,
        cabbageAmount: json['cabbage'] as int? ?? 0,
        capsicumAmount: json['capsicum'] as int? ?? 0,
        beansAmount: json['beans'] as int? ?? 0,
        disCode: json['disCode'] as String? ?? '',
        requestDate: json['requestdate']! as Timestamp,
        district: json['district'] as String? ?? '');
  }

  // Method to create a copy of Restock object with new values
  Restock copyWith(
      {int? carrotAmount,
      int? potatoAmount,
      int? cabbageAmount,
      int? capsicumAmount,
      int? beansAmount,
      String? disCode,
      Timestamp? requestdate,
      String? district}) {
    return Restock(
        carrotAmount: carrotAmount ?? this.carrotAmount,
        potatoAmount: potatoAmount ?? this.potatoAmount,
        cabbageAmount: cabbageAmount ?? this.cabbageAmount,
        capsicumAmount: capsicumAmount ?? this.capsicumAmount,
        beansAmount: beansAmount ?? this.beansAmount,
        disCode: disCode ?? this.disCode,
        requestDate: requestDate ?? this.requestDate,
        district: district ?? this.district);
  }

  // Method to convert Restock object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'carrot': carrotAmount,
      'potato': potatoAmount,
      'cabbage': cabbageAmount,
      'capsicum': capsicumAmount,
      'beans': beansAmount,
      'disCode': disCode,
      'requestdate': requestDate,
      'district': district
    };
  }
}
