import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/components/my_list_tile.dart';
import 'package:shopping_cart/firestore_services.dart';
import 'package:shopping_cart/utils/app_utils.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirestoreServices firestoreServices = FirestoreServices();
  final TextEditingController _noteController = TextEditingController();

  void addNote(String? id, String? noteTitle) {
    if (id != null) {
      _noteController.text = noteTitle ?? "";
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Note"),
          content: TextField(controller: _noteController),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _noteController.clear();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (id != null) {
                  firestoreServices.updateNote(id, _noteController.text);
                } else {
                  firestoreServices.addNote(_noteController.text);
                }
                Navigator.pop(context);
                _noteController.clear();
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void onDeleteNote(String id) {
    firestoreServices.deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: firestoreServices.getNotes(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            Utils.showSnackBar(context, snapshot.error.toString());
          }
          if (snapshot.hasData) {
            List notesList = snapshot.data!;
            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> noteData = notesList[index];
                String noteId = noteData['id'];
                String noteText = noteData['note'];

                return MyListTile(
                  title: noteText,
                  onEdit: () {
                    addNote(noteId, noteText);
                  },
                  onDelete: () {
                    onDeleteNote(noteId);
                  },
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNote(null, null);
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
