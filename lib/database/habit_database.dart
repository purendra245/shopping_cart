import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shopping_cart/models/app_settings.dart';
import 'package:shopping_cart/models/habit.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;
  List<Habit> currentHabits = [];

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([
      HabitSchema,
      AppSettingsSchema,
    ], directory: dir.path);
  }

  Future<void> saveFirstLaunchDate() async {
    final existingAppSettings = await isar.appSettings.where().findFirst();
    if (existingAppSettings == null) {
      final appSetting = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(appSetting));
    }
  }

  Future<DateTime?> getFirstLaunchDate() async {
    final appSettings = await isar.appSettings.where().findFirst();
    return appSettings?.firstLaunchDate;
  }

  Future<void> addHabit(Habit habit) async {
    final newHabit = Habit()..name = habit.name;
    await isar.writeTxn(() async {
      await isar.habits.put(newHabit);
    });
    readHabit();
  }

  Future<void> updateHabitCompleted(int id, bool isCompleted) async {
    final habit = await isar.habits.get(id);
    if (habit != null) {
      await isar.writeTxn(() async {
        if (isCompleted && !habit.completedDays.contains(DateTime.now())) {
          final today = DateTime.now();
          habit.completedDays.add(DateTime(today.year, today.month, today.day));
        } else {
          habit.completedDays.removeWhere(
            (element) =>
                element.year == DateTime.now().year &&
                element.month == DateTime.now().month &&
                element.day == DateTime.now().day,
          );
        }
        await isar.habits.put(habit);
      });
    }
    readHabit();
  }

  Future<void> updateHabitName(int id, String name) async {
    final habit = await isar.habits.get(id);
    if (habit != null) {
      await isar.writeTxn(() async {
        habit.name = name;
        await isar.habits.put(habit);
      });
    }
    readHabit();
  }

  Future<void> readHabit() async {
    final habits = await isar.habits.where().findAll();
    currentHabits.clear();
    currentHabits.addAll(habits);
    notifyListeners();
  }

  Future<void> deleteHabit(int id) async {
    await isar.writeTxn(() => isar.habits.delete(id));
    readHabit();
  }
}
