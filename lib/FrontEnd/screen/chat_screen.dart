import 'package:chat_app/Global/res/asset.dart';
import 'package:chat_app/Global/widget/custom_navbar.dart';
import 'package:flutter/material.dart';

import '../../Global/res/style.dart';
import '../../Global/widget/custom_appbar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final List<String> allUserConnectionActivity = ['Naibee', 'Dieu Trinh'];
  final List<String> allConnectionsUserName = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Chats',
        icon: Icons.edit_note,
      ),
      drawer: NavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            connectionList(context),
          ],
        ),
      ),
    );
  }

  Widget connectionList(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        left: 20,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: allUserConnectionActivity.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                /*iconColor: Colors.blue,
                tileColor: Colors.blue.withOpacity(0.1),*/
                leading: Image.asset(Id.facebook),
                title: Text(allUserConnectionActivity[index].toString()),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Message'),
                    Text('Time'),
                  ],
                ),
                onTap: () {
                },
              ),

              const SizedBox(height: 8),
            ],
          );
        },
      ),
    );
  }
}
