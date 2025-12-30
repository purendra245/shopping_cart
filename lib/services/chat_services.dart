import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_cart/models/chat_model.dart';

class ChatServices {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final String chatRoomCollection = 'chat_rooms';

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return db.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  Future<void> sendMessage(String recieverId, String message) async {
    final String currentUserId = auth.currentUser!.uid;
    final String currentUserEmail = auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
    ChatModel chatModel = ChatModel(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: recieverId,
      message: message,
      timestamp: timestamp,
    );

    // construct the chat room id for the two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserId, recieverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    await db
        .collection(chatRoomCollection)
        .doc(chatRoomId)
        .collection('messages')
        .add(chatModel.toMap());
  }

  // get message
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessage(
    String userId,
    String reciverID,
  ) {
    List<String> ids = [userId, reciverID];
    ids.sort();
    String chatRoomId = ids.join("_");

    return db
        .collection(chatRoomCollection)
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
