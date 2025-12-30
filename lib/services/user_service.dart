import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final fbStore = FirebaseFirestore.instance;
  String collectionName = 'Users';

  Future<void> createUserCredentials({
    required UserCredential? userCredential,
    required String userName,
  }) async {
    if (userCredential != null && userCredential.user != null) {
      await fbStore
          .collection(collectionName)
          .doc(userCredential.user!.email)
          .set({'email': userCredential.user!.email, 'username': userName});
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails(
    User? currentUser,
  ) async {
    return await fbStore
        .collection(collectionName)
        .doc(currentUser!.email)
        .get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return fbStore.collection(collectionName).snapshots();
  }
}
