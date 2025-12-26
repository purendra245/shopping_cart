import 'package:isar/isar.dart';

part 'habit.g.dart';

@collection
class Habit {
  Id id = Isar.autoIncrement;
  late String name;
  List<DateTime> completedDays = [
    //year,month,day
    //DateTime(2025, 12, 26),
  ];

}
