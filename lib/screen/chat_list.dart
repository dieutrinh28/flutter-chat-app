import 'package:chat_app/auth/login.dart';
import 'package:chat_app/firebase/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final EmailAndPasswordAuth emailAndPasswordAuth = EmailAndPasswordAuth();
  final GoogleAuthentication googleAuthentication = GoogleAuthentication();

  void onLogOutClick() async {
    final bool googleResponse = await googleAuthentication.logOut();

    if (!googleResponse) {
      await emailAndPasswordAuth.logOut();
    }

    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => LoginPage()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat List"),
      ),
      body: SingleChildScrollView(
          child: TextButton(
        onPressed: onLogOutClick,
        child: const Text('Log Out'),
      )),
    );
  }
}
