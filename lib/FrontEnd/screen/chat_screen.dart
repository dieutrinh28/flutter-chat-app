import 'package:chat_app/FrontEnd/screen/conversation_screen.dart';
import 'package:chat_app/Global/res/asset.dart';
import 'package:chat_app/Global/widget/custom_navbar.dart';
import 'package:flutter/material.dart';

import '../../Global/widget/custom_appbar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {

  final TextEditingController searchByUsernameController = TextEditingController();

  @override
  void dispose() {
    searchByUsernameController.dispose();
    super.dispose();
  }
  final List<String> allUserConnectionActivity = ['Naibee', 'Dieu Trinh'];
  final List<String> allConnectionsUserName = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Chats',
        icon: Icons.edit_note,
      ),
      drawer: const NavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            searchBar(),
            connectionList(),
          ],
        ),
      ),
    );
  }

  Widget searchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchByUsernameController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Search by username",
              ),
            ),
          ),
          const Icon(Icons.search)
        ],
      ),
    );
  }

  Widget connectionList() {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: allUserConnectionActivity.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                leading: Image.asset(Id.facebook),
                title: Text(allUserConnectionActivity[index].toString()),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Message'),
                    Text('Time'),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ConversationScreen(),
                    ),
                  );
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
