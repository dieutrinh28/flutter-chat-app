import 'package:chat_app/Global/widget/custom_navbar.dart';
import 'package:flutter/material.dart';

import '../../Global/widget/custom_appbar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Chats',
        icon: Icons.edit_note,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
      drawer: NavBar(),
    );
  }
}
