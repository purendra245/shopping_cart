import 'package:shopping_cart/models/habit.dart';

bool isCompleted(List<DateTime> completedDays) {
  final today = DateTime.now();
  return completedDays.any(
    (element) =>
        element.year == today.year &&
        element.month == today.month &&
        element.day == today.day,
  );
}

Map<DateTime, int> prepareHeatMapDataset(List<Habit> habits) {
  final Map<DateTime, int> data = {};
  for (var habit in habits) {
    for (var day in habit.completedDays) {
      final normalizedDate = DateTime(day.year, day.month, day.day);
      if (data.containsKey(normalizedDate)) {
        data[normalizedDate] = data[normalizedDate]! + 1;
      } else {
        data[normalizedDate] = 1;
      }
    }
  }
  return data;
}
