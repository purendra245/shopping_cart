import 'package:flutter/material.dart';
import 'package:shopping_cart/components/my_list_tile.dart';
import 'package:shopping_cart/components/my_text_filed.dart';
import 'package:shopping_cart/services/auth_service.dart';
import 'package:shopping_cart/services/chat_services.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverId;
  const ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverId,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final user = AuthService().currentUser;
  final TextEditingController _controllerMsg = TextEditingController();
  final ChatServices _chatServices = ChatServices();
  final AuthService _authService = AuthService();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        scrollDown();
      }
    });
    scrollDown();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _controllerMsg.dispose();
  }

  void scrollDown() {
    Future.delayed(const Duration(milliseconds: 500), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  void sendMessage() {
    if (_controllerMsg.text.isNotEmpty) {
      _chatServices.sendMessage(widget.receiverId, _controllerMsg.text);
    }
    _controllerMsg.clear();
    scrollDown();
  }

  Widget buildUsersListView(List<Map<String, dynamic>> messages) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      controller: _scrollController,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final messageData = messages[index];
        return MyListTile(
          title: messageData["message"],
          senderId: messageData["senderId"],
          currentUserId: _authService.currentUser!.uid,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String senderId = _authService.currentUser!.uid;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          widget.receiverEmail,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _chatServices.getMessage(widget.receiverId, senderId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Something went wrong +${snapshot.error}"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  final messageList = snapshot.data?.docs
                      .map((doc) => doc.data())
                      .toList();
                  return buildUsersListView(messageList!);
                }
                return const Center(child: Text("No Data"));
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: MyTextFiled(
                    hintText: "Type a Message",
                    obsecureText: false,
                    controller: _controllerMsg,
                    focusNode: _focusNode,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  sendMessage();
                },
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 30, right: 10),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
