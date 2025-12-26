import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/components/list_habit_tile.dart';
import 'package:shopping_cart/components/my_drawer.dart';
import 'package:shopping_cart/components/my_heatmap.dart';
import 'package:shopping_cart/database/habit_database.dart';
import 'package:shopping_cart/models/habit.dart';
import 'package:shopping_cart/utils/util.dart' as Util;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<HabitDatabase>(context, listen: false).readHabit();
  }

  final textController = TextEditingController();

  void addHabit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
          decoration: InputDecoration(hintText: 'Habit Name'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (textController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('please enter habit name')),
                );
                return;
              } else {
                final habit = Habit()..name = textController.text;
                Navigator.pop(context);
                Provider.of<HabitDatabase>(
                  context,
                  listen: false,
                ).addHabit(habit);
              }
            },
            child: Text(
              'Add',
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void deleteHabit(Habit habit) {
    Provider.of<HabitDatabase>(context, listen: false).deleteHabit(habit.id);
  }

  void editHabit(Habit habit) {
    textController.text = habit.name;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
          decoration: InputDecoration(hintText: 'Habit Name'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (textController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('please enter habit name')),
                );
                return;
              } else {
                Navigator.pop(context);
                Provider.of<HabitDatabase>(
                  context,
                  listen: false,
                ).updateHabitName(habit.id, textController.text);
              }
            },
            child: Text(
              'Update',
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void checkHabitOnOff(Habit habit, bool? value) {
    Provider.of<HabitDatabase>(
      context,
      listen: false,
    ).updateHabitCompleted(habit.id, value ?? false);
    debugPrint("checkHabitOnOff called" + habit.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    final habitProvider = Provider.of<HabitDatabase>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: const Text('Habit Tracker')),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addHabit();
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: ListView(
        children: [
          _buildHeatMap(),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: habitProvider.currentHabits.length,
            itemBuilder: (context, index) {
              final habit = habitProvider.currentHabits[index];
              final isCompleted = Util.isCompleted(habit.completedDays);
              return ListHabitTile(
                habit: habit,
                isCompleted: isCompleted,
                onChanged: (value) {
                  debugPrint("on check called");
                  checkHabitOnOff(habit, value);
                },
                onEdit: (context) {
                  editHabit(habit);
                },
                onDelete: (context) {
                  deleteHabit(habit);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeatMap() {
    final database = context.watch<HabitDatabase>();
    final List<Habit> currentHabits = database.currentHabits;
    return FutureBuilder<DateTime?>(
      future: database.getFirstLaunchDate(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MyHeatMap(
            startDate: snapshot.data!,
            data: Util.prepareHeatMapDataset(currentHabits),
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
