import 'package:adminapp/models/BlogModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Collection name in Firestore
const String BLOG_COLLECTION_REF = "Blog";

class BlogDatabaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference<Blog> _blogRef;

  BlogDatabaseServices() {
    _blogRef = _firestore.collection(BLOG_COLLECTION_REF).withConverter<Blog>(
          fromFirestore: (snapshot, _) => Blog.fromJson(snapshot.data()!),
          toFirestore: (blog, _) => blog.toJson(),
        );
  }

  // Get blogs from database as a stream
  Stream<QuerySnapshot<Blog>> getBlogs() {
    return _blogRef.orderBy('createdOn', descending: true).snapshots();
  }

  // Add blog to database
  Future<void> addBlog(Blog blog) async {
    await _blogRef.add(blog);
  }

  // Update blog in database
  Future<void> updateBlog(String blogId, Blog updatedBlog) async {
    await _blogRef.doc(blogId).set(updatedBlog);
  }

  // Delete blog from database
  Future<void> deleteBlog(String blogId) async {
    await _blogRef.doc(blogId).delete();
  }
}
