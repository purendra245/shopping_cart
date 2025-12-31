import 'package:flutter/material.dart';
import 'package:shopping_cart/data/models/player_response.dart';

class MyListTile extends StatelessWidget {
  const MyListTile({super.key, required this.player});

  final PlayerModel player;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          '${player.firstName} ${player.lastName}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          player.country,
          style: const TextStyle(fontSize: 16, color: Colors.pink),
        ),
      ),
    );
  }
}
