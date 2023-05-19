import 'package:chat_app/FrontEnd/auth/login.dart';
import 'package:chat_app/Backend/firebase/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
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
