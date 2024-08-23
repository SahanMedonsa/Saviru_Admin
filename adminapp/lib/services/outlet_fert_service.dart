import 'package:adminapp/models/fertilize_outlet_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


// Collection name in Firestore
const String FERTILIZER_COLLECTION_REF = "fertilizer";

class FertilizerOutletDatabaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference<FertilizerOutlet> _outletRef;

  FertilizerOutletDatabaseServices() {
    _outletRef = _firestore.collection(FERTILIZER_COLLECTION_REF).withConverter<FertilizerOutlet>(
      fromFirestore: (snapshot, _) => FertilizerOutlet.fromJson(snapshot.data()!),
      toFirestore: (outlet, _) => outlet.toJson(),
    );
  }

  // Get outlets from database
  Stream<QuerySnapshot<FertilizerOutlet>> getOutlets() {
    return _outletRef.snapshots();
  }

  // Add outlet to database
  Future<void> addOutlet(FertilizerOutlet outlet) async {
    await _outletRef.add(outlet);
  }

  // Update outlet in database
  Future<void> updateOutlet(String outletId, FertilizerOutlet outlet) {
    return _outletRef.doc(outletId).update(outlet.toJson());
  }

  // Delete outlet from database
  Future<void> deleteOutlet(String outletId) {
    return _outletRef.doc(outletId).delete();
  }
}
