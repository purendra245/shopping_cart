import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  final CollectionReference _noteCollection = FirebaseFirestore.instance
      .collection("notes");

  Future<void> addNote(String note) async {
    await _noteCollection.add({"note": note, 'timestamp': Timestamp.now()});
  }

  Stream<List<Map<String, dynamic>>> getNotes() {
    // return _notesCollection
    //     .orderBy('timestamp', descending: true) // Sort logic
    //     .snapshots()
    //     .map((snapshot) {
    //       return snapshot.docs.map((doc) {
    //         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    //         data['id'] = doc.id;
    //         return data;
    //       }).toList();
    //     }); OR

    return _noteCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => {...doc.data() as Map<String, dynamic>, 'id': doc.id},
              )
              .toList(),
        );
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
