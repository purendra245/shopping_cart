import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/component/drawer_tile.dart';
import 'package:shopping_cart/component/note_tile.dart';
import 'package:shopping_cart/model/note_database.dart';
import 'package:shopping_cart/model/note_model.dart';
import 'package:shopping_cart/pages/setting_page.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

TextEditingController _controller = TextEditingController();

class _NotePageState extends State<NotePage> {
  @override
  initState() {
    super.initState();
    fetchNotes();
  }

  void addNote() {
    TextField textField = TextField(controller: _controller);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Note"),
        content: textField,
        actions: [
          TextButton(
            onPressed: () {
              if (_controller.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Note cannot be empty")),
                );
                return;
              } else {
                Provider.of<NoteDatabase>(
                  context,
                  listen: false,
                ).addNewNote(_controller.text);
                _controller.clear();
                Navigator.pop(context);
              }
            },
            child: Text(
              "Add",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void fetchNotes() {
    Provider.of<NoteDatabase>(context, listen: false).fetchNotes();
  }

  void deleteNote(int id) {
    Provider.of<NoteDatabase>(context, listen: false).deleteNote(id);
  }

  void updateNotes(NoteModel note) {
    _controller.text = note.title;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update Note"),
        content: TextField(controller: _controller),
        actions: [
          TextButton(
            onPressed: () {
              if (_controller.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Note cannot be empty")),
                );
                return;
              } else {
                Provider.of<NoteDatabase>(
                  context,
                  listen: false,
                ).updateNote(note.id, _controller.text);
                _controller.clear();
                Navigator.pop(context);
              }
            },
            child: Text(
              "Update",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<NoteDatabase>(context).currentNotes;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "Notes",
              style: GoogleFonts.dmSerifText(
                fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return NoteTile(
                  title: note.title,
                  onUpdate: () => updateNotes(note),
                  onDelete: () => deleteNote(note.id),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNote();
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(child: Icon(Icons.notes)),
            SizedBox(height: 20),
            DrawerTile(
              title: "Home",
              icon: Icons.home,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            DrawerTile(
              title: "Settings",
              icon: Icons.settings,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
