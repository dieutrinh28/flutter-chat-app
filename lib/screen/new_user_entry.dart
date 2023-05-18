import 'package:chat_app/firebase/firestore.dart';
import 'package:chat_app/screen/chat_list.dart';
import 'package:chat_app/widget/custom_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../res/style.dart';
import '../widget/custom_button.dart';

class TakePrimaryUserData extends StatefulWidget {
  const TakePrimaryUserData({Key? key}) : super(key: key);

  @override
  State<TakePrimaryUserData> createState() => _TakePrimaryUserDataState();
}

class _TakePrimaryUserDataState extends State<TakePrimaryUserData> {
  final formKey = GlobalKey<FormState>();

  final userNameController = TextEditingController();
  final userAboutController = TextEditingController();

  final CloudStoreDataManagement cloudStoreDataManagement =
      CloudStoreDataManagement();

  @override
  void dispose() {
    userNameController.dispose();
    userAboutController.dispose();
    super.dispose();
  }

  void onSaveClick() async {
    final isValid = formKey.currentState?.validate();
    if (isValid != null && isValid == true) {
      formKey.currentState?.save();

      final bool userNamePresentResponse = await cloudStoreDataManagement
          .checkThisUserAlreadyPresentOrNot(userName: userNameController.text);
      String msg = "";
      if (userNamePresentResponse) {
        msg = 'Username Already Present';
      } else {
        final bool userEntryResponse =
            await cloudStoreDataManagement.registerNewUser(
          userName: userNameController.text,
          userAbout: userAboutController.text,
          userEmail: FirebaseAuth.instance.currentUser!.email.toString(),
        );

        if (userEntryResponse) {
          msg = 'User data Entry Successfully';
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const ChatList()),
              (route) => false);
        } else {
          msg = 'User data Not Entry Successfully';
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              const Text(
                'Set Additional Details',
                style: PrimaryFont.subtitleLargeBold,
              ),
              const Text(
                "Username",
                style: PrimaryFont.subtitleSmallBold,
              ),
              const SizedBox(height: 8),
              InputFieldNonIcon(
                controller: userNameController,
                validator: (userName) {
                  final RegExp messageRegex = RegExp(r'[a-zA-Z\d]');

                  if (userName!.length < 6) {
                    return "User Name At Least 6 Characters";
                  } else if (userName.contains(' ') || userName.contains('@')) {
                    return "Space and '@' Not Allowed...User '_' instead of space";
                  } else if (userName.contains('__')) {
                    return "'__' Not Allowed...User '_' instead of '__'";
                  } else if (!messageRegex.hasMatch(userName)) {
                    return "Sorry,Only Emoji Not Supported";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              const Text(
                "About Yourself",
                style: PrimaryFont.subtitleSmallBold,
              ),
              const SizedBox(height: 8),
              InputFieldNonIcon(
                controller: userAboutController,
                validator: (userAbout) {
                  if (userAbout!.length < 6) {
                    return 'User About must have 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: PrimaryButton(
                  name: 'Save',
                  onPressed: onSaveClick,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
