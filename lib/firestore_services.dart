import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  final CollectionReference _noteCollection = FirebaseFirestore.instance
      .collection("notes");

  Future<void> addNote(String note) async {
    await _noteCollection.add({"note": note, 'timestamp': Timestamp.now()});
  }

  Stream<QuerySnapshot> getNotes() {
    return _noteCollection.orderBy('timestamp', descending: true).snapshots();
  }

  Future<void> deleteNote(String id) async {
    await _noteCollection.doc(id).delete();
  }

  Future<void> updateNote(String id, String note) async {
    await _noteCollection.doc(id).update({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }
}
