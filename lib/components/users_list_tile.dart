import 'package:flutter/material.dart';

class UsersListTile extends StatelessWidget {
  final String title;
  final Function() onTap;
  const UsersListTile({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 22),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        child: ListTile(
          leading: Icon(
            Icons.person,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          title: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onInverseSurface,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
