import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final Function()? onTap;
  const MyListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ListTile(
          leading: Image.asset(imageUrl, height: 50, width: 50),
          title: Text(title),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }
}
