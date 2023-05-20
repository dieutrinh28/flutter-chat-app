import 'package:flutter/material.dart';

import '../../Global/widget/custom_appbar.dart';
import '../../Global/widget/custom_navbar.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({Key? key}) : super(key: key);

  @override
  State<StoryScreen> createState() => StoryScreenState();
}

class StoryScreenState extends State<StoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Stories',
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
