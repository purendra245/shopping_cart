import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shopping_cart/models/habit.dart';

class ListHabitTile extends StatelessWidget {
  final Habit habit;
  final bool isCompleted;
  final void Function(bool?) onChanged;
  final void Function(BuildContext)? onEdit;
  final void Function(BuildContext)? onDelete;

  const ListHabitTile({
    super.key,
    required this.habit,
    required this.isCompleted,
    required this.onChanged,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: onEdit,
            backgroundColor: Colors.grey.shade800,
            icon: Icons.settings,
            borderRadius: BorderRadius.circular(8),
          ),
          SizedBox(width: 10),
          SlidableAction(
            onPressed: onDelete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(8),
            icon: Icons.delete,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          onChanged(!isCompleted);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: isCompleted
                ? Colors.green
                : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            title: Text(
              habit.name,
              style: TextStyle(
                color: isCompleted
                    ? Colors.white
                    : Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            leading: Checkbox(
              activeColor: Colors.green,
              value: isCompleted,
              onChanged: onChanged,
            ),
          ),
        ),
      ),
    );
  }
}
