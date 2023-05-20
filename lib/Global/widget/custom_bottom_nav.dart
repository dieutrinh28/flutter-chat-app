import 'package:flutter/material.dart';

import '../../FrontEnd/screen/call_screen.dart';
import '../../FrontEnd/screen/chat_screen.dart';
import '../../FrontEnd/screen/people_screen.dart';
import '../../FrontEnd/screen/story_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => BottomNavState();
}

class BottomNavState extends State<BottomNav> {
  int selectedIndex = 0;
  List<BottomNavigationBarItem> bottomNavBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.chat),
      label: 'Chats',
      activeIcon: Icon(
        Icons.chat,
        color: Colors.cyanAccent,
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.videocam),
      label: 'Calls',
      activeIcon: Icon(
        Icons.videocam,
        color: Colors.cyanAccent,
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.people),
      label: 'People',
      activeIcon: Icon(
        Icons.people,
        color: Colors.cyanAccent,
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.web_stories),
      label: 'Stories',
      activeIcon: Icon(
        Icons.web_stories,
        color: Colors.cyanAccent,
      ),
    ),
  ];

  List<Widget> pages = const [
    ChatScreen(),
    CallScreen(),
    PeopleScreen(),
    StoryScreen(),
  ];

  void onNavBarItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: bottomNavBarItems,
        currentIndex: selectedIndex,
        onTap: onNavBarItemTapped,
        selectedItemColor: Colors.cyanAccent,
        backgroundColor: Colors.white,
      ),
    );
  }
}
