import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/components/my_list_tile.dart';
import 'package:shopping_cart/services/user_service.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.secondary),
      body: StreamBuilder(
        stream: UserService().getAllUsers(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            final users = snapshot.data!.docs;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final Map<String, dynamic> user =
                    users[index].data() as Map<String, dynamic>;
                return MyListTile(
                  title: user['username'],
                  subtitle: user['email'],
                );
              },
            );
          }
          return const Center(child: Text("No Data"));
        },
      ),
    );
  }
}
