import 'package:flutter/material.dart';

import '../../Global/widget/custom_appbar.dart';
import '../../Global/widget/custom_navbar.dart';

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({Key? key}) : super(key: key);

  @override
  State<PeopleScreen> createState() => PeopleScreenState();
}

class PeopleScreenState extends State<PeopleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Peolple',
        icon: Icons.contact_phone,
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
