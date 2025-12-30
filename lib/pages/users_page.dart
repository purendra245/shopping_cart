import 'package:flutter/material.dart';
import 'package:shopping_cart/components/my_drawer.dart';
import 'package:shopping_cart/components/users_list_tile.dart';
import 'package:shopping_cart/pages/chat_page.dart';
import 'package:shopping_cart/services/auth_service.dart';
import 'package:shopping_cart/services/chat_services.dart';

class UsersPage extends StatefulWidget {
  UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final chatServices = ChatServices();

  final authService = AuthService();
  late Stream<List<Map<String, dynamic>>> _userStream;

  @override
  void initState() {
    super.initState();
    _userStream = chatServices.getUserStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: Text(
          "U S E R S",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 18,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: buildUserList(),
      drawer: MyDrawer(),
    );
  }

  Widget buildUserList() {
    return StreamBuilder(
      stream: _userStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Something went wrong +${snapshot.error}"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          final filteredUsers = snapshot.data!
              .where((user) => user["email"] != authService.currentUser?.email)
              .toList();
          return buildUsersListView(filteredUsers);
        }
        return const Center(child: Text("No Data"));
      },
    );
  }

  Widget buildUsersListView(List<Map<String, dynamic>> users) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: users.length,
      itemBuilder: (context, index) {
        final userData = users[index];
        return UsersListTile(
          title: userData["email"],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  receiverEmail: userData["email"],
                  receiverId: userData["uid"],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
