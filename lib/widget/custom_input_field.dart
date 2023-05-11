import 'package:flutter/material.dart';

import '../res/asset.dart';
import '../res/color.dart';
import '../res/style.dart';

class InputFieldNonIcon extends StatefulWidget {
  final TextEditingController controller;
  final FormFieldValidator<String> validator;

  const InputFieldNonIcon({
    Key? key,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  @override
  State<InputFieldNonIcon> createState() => InputFieldNonIconState();
}

class InputFieldNonIconState extends State<InputFieldNonIcon> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorColor: Cl.brandPrimaryDark,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
          borderSide: BorderSide(
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Cl.grayscaleLine,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Cl.brandPrimaryBase,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Cl.statesErrorBase,
          ),
        ),
        errorStyle: PrimaryFont.textXSmall.copyWith(
          color: Cl.statesErrorBase,
        ),
      ),
    );
  }
}

class InputFieldIconRight extends StatefulWidget {
  final IconData rightIcon;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;

  const InputFieldIconRight({
    Key? key,
    required this.rightIcon,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  @override
  State<InputFieldIconRight> createState() => InputFieldIconRightState();
}

class InputFieldIconRightState extends State<InputFieldIconRight> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorColor: Cl.brandPrimaryDark,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        suffixIcon: InkWell(
          child: SizedBox(
            width: 20,
            height: 20,
            child: Icon(
              widget.rightIcon,
            ),
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
          borderSide: BorderSide(
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Cl.grayscaleLine,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Cl.brandPrimaryBase,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Cl.statesErrorBase,
          ),
        ),
        errorStyle: PrimaryFont.textXSmall.copyWith(
          color: Cl.statesErrorBase,
        ),
      ),
    );
  }
}

class InputFieldPassword extends StatefulWidget {
  final TextEditingController controller;
  final FormFieldValidator<String> validator;

  const InputFieldPassword({
    Key? key,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  @override
  State<InputFieldPassword> createState() => InputFieldPasswordState();
}

class InputFieldPasswordState extends State<InputFieldPassword> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorColor: Cl.brandPrimaryDark,
      obscureText: isHidden,
      obscuringCharacter: '*',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        suffixIcon: InkWell(
          onTap: () {
            setState(() {
              isHidden = !isHidden;
            });
          },
          child: SizedBox(
            width: 20,
            height: 20,
            child: Image.asset(
              isHidden ? Id.previewClose : Id.eyes,
            ),
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
          borderSide: BorderSide(
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Cl.grayscaleLine,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Cl.brandPrimaryBase,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Cl.statesErrorBase,
          ),
        ),
        errorStyle: PrimaryFont.textXSmall.copyWith(
          color: Cl.statesErrorBase,
        ),
      ),
    );
  }
}
