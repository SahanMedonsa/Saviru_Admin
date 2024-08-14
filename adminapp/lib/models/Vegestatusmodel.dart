import 'package:cloud_firestore/cloud_firestore.dart';

class VegetableStatus {
  Timestamp date;
  double carrot;
  double cabbage;
  double potato;
  double brinjal;
  double capsicum;

  VegetableStatus({
    required this.date,
    required this.carrot,
    required this.cabbage,
    required this.potato,
    required this.brinjal,
    required this.capsicum,
  });

  // Create an instance from JSON
  VegetableStatus.fromJson(Map<String, Object?> json)
      : this(
          date: json['date']! as Timestamp,
          carrot: (json['carrot'] as num?)?.toDouble() ?? 0.0,
          cabbage: (json['cabbage'] as num?)?.toDouble() ?? 0.0,
          potato: (json['potato'] as num?)?.toDouble() ?? 0.0,
          brinjal: (json['brinjal'] as num?)?.toDouble() ?? 0.0,
          capsicum: (json['capsicum'] as num?)?.toDouble() ?? 0.0,
        );

  // Copy an instance with optional modifications
  VegetableStatus copyWith({
    Timestamp? date,
    double? carrot,
    double? cabbage,
    double? potato,
    double? brinjal,
    double? capsicum,
  }) {
    return VegetableStatus(
      date: date ?? this.date,
      carrot: carrot ?? this.carrot,
      cabbage: cabbage ?? this.cabbage,
      potato: potato ?? this.potato,
      brinjal: brinjal ?? this.brinjal,
      capsicum: capsicum ?? this.capsicum,
    );
  }

  // Convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'carrot': carrot,
      'cabbage': cabbage,
      'potato': potato,
      'brinjal': brinjal,
      'capsicum': capsicum,
    };
  }
}
