import 'package:chat_app/firebase/auth.dart';
import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EmailAndPasswordAuth emailAndPasswordAuth = EmailAndPasswordAuth();
    void onLogOutClick() {
      emailAndPasswordAuth.logOut();
      Navigator.pop(context);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat List"),
      ),
      body: SingleChildScrollView(
        child: TextButton(
          child: Text('Log Out'),
          onPressed: onLogOutClick,
        )
      ),
    );
  }
}
