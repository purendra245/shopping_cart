import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shopping_cart/component/dilaog_box.dart';
import 'package:shopping_cart/component/list_title.dart';
import 'package:shopping_cart/to_do_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final mybox = Hive.box('myBox');

  ToDoDatabase database = ToDoDatabase();

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    if (mybox.get('todoList') == null) {
      database.createInitialData();
    } else {
      database.loadData();
    }
    super.initState();
  }

  void changeCheckBox(int index, bool? value) {
    setState(() {
      database.todoList[index][1] = !database.todoList[index][1];
      database.updateDatabase();
    });
  }

  void saveNewTask() {
    setState(() {
      database.todoList.add([_controller.text, false]);
      _controller.clear();
      Navigator.of(context).pop();
      database.updateDatabase();
    });
  }

  void deleteTask(int index) {
    setState(() {
      database.todoList.removeAt(index);
    });
    database.updateDatabase();
  }

  void createTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(title: const Text("To Do App")),
      floatingActionButton: FloatingActionButton(
        onPressed: createTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: database.todoList.length,
        itemBuilder: (context, index) => ListTitle(
          title: database.todoList[index][0],
          isTaskCompleted: database.todoList[index][1],
          onChanged: (value) => changeCheckBox(index, value),
          deleteFunction: (context) => deleteTask(index),
        ),
      ),
    );
  }
}
