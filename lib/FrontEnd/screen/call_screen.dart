import 'package:flutter/material.dart';

import '../../Global/widget/custom_appbar.dart';
import '../../Global/widget/custom_navbar.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => CallScreenState();
}

class CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Calls',
        icon: Icons.videocam,
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
