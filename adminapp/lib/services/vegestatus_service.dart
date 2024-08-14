
import 'package:adminapp/models/Vegestatusmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Collection name in Firestore
const String vege_COLLECTION_REF = "vegestatus";

class VegestatusDatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference<VegetableStatus> _vegeRef;

  VegestatusDatabaseService() {
    _vegeRef = _firestore.collection(vege_COLLECTION_REF).withConverter<VegetableStatus>(
          fromFirestore: (snapshot, _) => VegetableStatus.fromJson(snapshot.data()!),
          toFirestore: (vege, _) => vege.toJson(),
        );
  }

  // Get blogs from database as a stream
  Stream<QuerySnapshot<VegetableStatus>> getVege() {
    return _vegeRef.orderBy('date', descending: true).snapshots();
  }

  // Add blog to database
  Future<void> addVege(VegetableStatus vege) async {
    await _vegeRef.add(vege);
  }

  // Update blog in database
  Future<void> updateVege(String vegeId, VegetableStatus updatedBlog) async {
    await _vegeRef.doc(vegeId).set(updatedBlog);
  }

  // Delete blog from database
  Future<void> deleteVege(String vegeId) async {
    await _vegeRef.doc(vegeId).delete();
  }
}
