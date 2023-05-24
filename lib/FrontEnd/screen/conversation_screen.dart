import 'package:chat_app/Global/res/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Global/widget/custom_appbar.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({Key? key}) : super(key: key);

  @override
  State<ConversationScreen> createState() => ConversationScreenState();
}

class ConversationScreenState extends State<ConversationScreen> {
  final TextEditingController sendMessageController = TextEditingController();

  CollectionReference<Map<String, dynamic>> messagesCollection =
      FirebaseFirestore.instance.collection('messages');

  @override
  void dispose() {
    super.dispose();
    sendMessageController.dispose();
  }

  void sendMessage() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Username',
        icon: Icons.arrow_back_ios,
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: messagesCollection.orderBy('timestamp').snapshots(),
            builder: (context, snapshot) {
              List<QueryDocumentSnapshot<Map<String, dynamic>>> messages =
                  snapshot.data!.docs;

              return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index].data();
                    return ListTile(
                      title: Text(message['content']),
                    );
                  });
            },
          )),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Text('Send a message'),
                  ),
                  /* TextFormField(
                    decoration: InputDecoration(hintText: 'Send a message'),
                  ),*/
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.send),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
