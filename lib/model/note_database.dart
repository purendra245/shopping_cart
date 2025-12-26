import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shopping_cart/model/note_model.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteModelSchema], directory: dir.path);
  }

  final List<NoteModel> currentNotes = [];

  Future<void> addNewNote(String title) async {
    final note = NoteModel()..title = title;
    await isar.writeTxn(() => isar.noteModels.put(note));
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    List<NoteModel> notes = await isar.noteModels.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(notes);
    notifyListeners();
  }

  Future<void> updateNote(int id, String title) async {
    final existingNote = await isar.noteModels.get(id);
    if (existingNote != null) {
      existingNote.title = title;
      await isar.writeTxn(() => isar.noteModels.put(existingNote));
      await fetchNotes();
    }
  }

  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.noteModels.delete(id));
    await fetchNotes();
  }
}
