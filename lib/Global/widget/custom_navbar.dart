import 'package:chat_app/FrontEnd/screen/chat_screen.dart';
import 'package:chat_app/Global/widget/custom_bottom_nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Backend/firebase/auth.dart';
import '../../FrontEnd/auth/login.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  final EmailAndPasswordAuth emailAndPasswordAuth = EmailAndPasswordAuth();
  final GoogleAuthentication googleAuthentication = GoogleAuthentication();

  void onLogOutClick() async {
    final bool googleResponse = await googleAuthentication.logOut();

    if (!googleResponse) {
      await emailAndPasswordAuth.logOut();
    }

    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => const LoginPage()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            accountName: Text('Name'),
            accountEmail: Text('Email'),
          ),
          ListTile(
              leading: const Icon(Icons.chat),
              title: const Text('Chats'),
              onTap: () {
                Navigator.pop(context);
              }),
          ListTile(
            leading: const Icon(Icons.store_sharp),
            title: const Text('Marketplace'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.message_sharp),
            title: const Text('Message requests'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.archive_sharp),
            title: const Text('Archive'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            color: Colors.black12,
            thickness: 2,
          ),
          ListTile(
            leading: const Icon(Icons.output_sharp),
            title: const Text('Logout'),
            onTap: onLogOutClick,
          ),
        ],
      ),
    );
  }
}
