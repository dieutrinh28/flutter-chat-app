import 'package:flutter/material.dart';

import '../res/color.dart';
import '../res/style.dart';

class PrimaryButton extends StatefulWidget {
  final String name;
  final VoidCallback onPressed;
  final bool isEnabled;
  final bool isLoading;

  const PrimaryButton({
    Key? key,
    required this.name,
    required this.onPressed,
    this.isEnabled = true,
    this.isLoading = false,
  }) : super(key: key);

  @override
  State<PrimaryButton> createState() => PrimaryButtonState();
}

class PrimaryButtonState extends State<PrimaryButton> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:
          (widget.isEnabled && !widget.isLoading) ? widget.onPressed : null,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return Cl.grayscaleDisabled;
            } else if (states.contains(MaterialState.hovered)) {
              return Cl.brandPrimaryLight;
            } else if (states.contains(MaterialState.pressed)) {
              return Cl.brandPrimaryDark;
            } else if (widget.isLoading) {
              return Cl.brandPrimaryBase;
            } else {
              return Cl.brandPrimaryBase;
            }
          },
        ),
        elevation: const MaterialStatePropertyAll(0),
      ),
      child: Text(
        widget.name,
        textAlign: TextAlign.center,
        style: PrimaryFont.subtitleSmallBold.copyWith(
          color: !widget.isEnabled ? Cl.grayscaleAccent : Cl.brandPrimaryBg,
        ),
      ),
    );
  }
}

