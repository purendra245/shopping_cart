import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/themes/theme_provider.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final String senderId;
  final String currentUserId;
  const MyListTile({
    super.key,
    required this.title,
    required this.currentUserId,
    required this.senderId,
  });

  @override
  Widget build(BuildContext context) {
    bool isMe = senderId == currentUserId;
    bool isDarkMode = Provider.of<ThemeProvider>(
      context,
      listen: false,
    ).isDarkMode;
    final alignment = isMe ? Alignment.centerRight : Alignment.centerLeft;
    return Align(
      alignment: alignment,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 22),
        decoration: BoxDecoration(
          color: isMe
              ? (isDarkMode ? Colors.green.shade900 : Colors.green.shade600)
              : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade50),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
