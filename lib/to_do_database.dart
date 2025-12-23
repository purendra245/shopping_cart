import 'package:hive/hive.dart';

class ToDoDatabase {
  List todoList = [];
  final _mybox = Hive.box('myBox');

  void createInitialData() {
    todoList = [
      ["Make Tutorial", false],
      ["Do Exercise", false],
    ];
  }

  void loadData() {
    todoList = _mybox.get('todoList');
  }

  void updateDatabase() {
    _mybox.put('todoList', todoList);
  }
}
