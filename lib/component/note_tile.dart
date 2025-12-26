import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:shopping_cart/component/note_setting.dart';

class NoteTile extends StatelessWidget {
  final String title;
  final Function()? onUpdate;
  final Function()? onDelete;
  const NoteTile({
    super.key,
    required this.title,
    this.onUpdate,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        trailing: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            onPressed: () => showPopover(
              context: context,
              bodyBuilder: (context) =>
                  NoteSetting(onUpdate: onUpdate, onDelete: onDelete),
              width: 100,
              height: 100,
            ),
          ),
        ),
      ),
    );
  }
}
