import 'package:flutter/material.dart'
    show
        BuildContext,
        Widget,
        StatelessWidget,
        ListTile,
        Icon,
        Text,
        IconData,
        Colors;
import 'package:flutter/painting.dart';

class MyListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function()? onTap;

  const MyListTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(title, style: TextStyle(color: Colors.grey.shade900)),
      onTap: onTap,
    );
  }
}
