import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_cart/services/auth_service.dart';

class PostService {
  final currentUser = AuthService().currentUser;
  final CollectionReference posts = FirebaseFirestore.instance.collection(
    'Posts',
  );

  Future<void> addPost(String message) async {
    try {
      await posts.add({
        'PostMessage': message,
        'uid': currentUser!.uid,
        'UserEmail': currentUser!.email,
        'Timestamp': Timestamp.now(),
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<QuerySnapshot> getPostsStream() {
    return posts.orderBy('Timestamp', descending: true).snapshots();
  }

  Future<void> deletePost(String id) async {
    try {
      await posts.doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }
}
