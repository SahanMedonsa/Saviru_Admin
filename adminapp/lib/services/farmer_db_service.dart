import 'package:adminapp/models/FarmerDetailmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//collection name in DataBase
const String FARMER_COLLECTION_REF = "farmer";

class FarmerDatabaseServices {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference<Farmer> _faremerRef;

//json  withconverter
  FarmerDatabaseServices() {
    _faremerRef = _firestore
        .collection(FARMER_COLLECTION_REF)
        .withConverter<Farmer>(
            fromFirestore: (snapshots, _) => Farmer.fromJson(snapshots.data()!),
            toFirestore: (farmer, _) => farmer.toJson());
  }

  //get todo from database
  Stream<QuerySnapshot> getfarmers() {
    return _faremerRef.snapshots();
  }

  //add todo to databse
  void addfarmer(Farmer farmer) async {
    _faremerRef.add(farmer);
  }

  //update todo
  void updatefarmer(String farmerId, Farmer farmer) {
    _faremerRef.doc(farmerId).update(farmer.toJson());
  }

  //deleted todo
  void deletefarmer(String farmerId) {
    _faremerRef.doc(farmerId).delete();
  }

   // New method to search by NIC
   Stream<List<Farmer>> searchFarmersByNIC(String nic) {
    return _faremerRef.where('nic', isEqualTo: nic).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => doc.data()).toList());
  }
}
