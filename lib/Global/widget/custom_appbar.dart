import 'package:flutter/material.dart';

import '../res/color.dart';
import '../res/style.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final IconData? icon;
  const CustomAppBar({
    Key? key,
    required this.title,
    this.icon,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomAppBarState extends State<CustomAppBar> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(
            color: Color.fromRGBO(102, 102, 102, 0.08),
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 0,
          ),
          icon: const Icon(
            Icons.density_medium_sharp,
            color: Cl.grayscaleText,
            size: 24,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        title: Text(
          widget.title,
          style: PrimaryFont.subtitleLargeBold,
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              widget.icon,
              size: 24,
              color: Cl.grayscaleText,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 0,
            ),
          )
        ],
      ),
    );
  }
}
