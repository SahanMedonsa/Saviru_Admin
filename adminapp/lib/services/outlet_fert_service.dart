 // Make sure this path is correct
import 'package:adminapp/models/fertilize_outlet_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Collection name in Firestore
const String OUTLET_COLLECTION_REF = "fertilizer";

class FertilizerOutletDatabaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference<FertilizerOutlet> _outletRef;

  FertilizerOutletDatabaseServices() {
    _outletRef = _firestore.collection(OUTLET_COLLECTION_REF).withConverter<FertilizerOutlet>(
      fromFirestore: (snapshot, _) => FertilizerOutlet.fromJson(snapshot.data()!),
      toFirestore: (outlet, _) => outlet.toJson(),
    );
  }

  // Get fertilizer outlets from database as a stream
 // Corrected this method in the Database Service
Stream<QuerySnapshot<FertilizerOutlet>> getFertilizerOutlets() {
  return _outletRef.snapshots();
}


  // Add fertilizer outlet to database
  Future<void> addFertilizerOutlet(FertilizerOutlet outlet) async {
    await _outletRef.add(outlet);
  }

  // Update fertilizer outlet in database
  Future<void> updateFertilizerOutlet(String outletId, FertilizerOutlet updatedOutlet) async {
    await _outletRef.doc(outletId).set(updatedOutlet);
  }

  // Delete fertilizer outlet from database
  Future<void> deleteFertilizerOutlet(String outletId) async {
    await _outletRef.doc(outletId).delete();
  }
}
