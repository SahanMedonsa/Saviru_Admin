import 'package:adminapp/models/RestockModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Collection name in Firestore
const String RESTOCK_COLLECTION_REF = "Restock";

class RestockDatabaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference<Restock> _restockRef;

  RestockDatabaseServices() {
    _restockRef = _firestore
        .collection(RESTOCK_COLLECTION_REF)
        .withConverter<Restock>(
          fromFirestore: (snapshot, _) => Restock.fromJson(snapshot.data()!),
          toFirestore: (restock, _) => restock.toJson(),
        );
  }

  // Get blogs from database as a stream
  Stream<QuerySnapshot<Restock>> getRestock() {
    return _restockRef.orderBy('requestdate', descending: true).snapshots();
  }

  // Add blog to database
  Future<void> addRestock(Restock blog) async {
    await _restockRef.add(blog);
  }

  // Update blog in database
  Future<void> updateRestock(String blogId, Restock updatedBlog) async {
    await _restockRef.doc(blogId).set(updatedBlog);
  }

  // Delete blog from database
  Future<void> deleteRestock(String restockId) async {
    await _restockRef.doc(restockId).delete();
  }
}
