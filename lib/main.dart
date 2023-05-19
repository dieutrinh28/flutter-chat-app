import 'package:chat_app/Backend/firebase/firestore.dart';
import 'package:chat_app/FrontEnd/screen/main_screen.dart';
import 'package:chat_app/FrontEnd/screen/new_user_entry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'FrontEnd/auth/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: await differentContextDecisionTake(),
    ),
  );
}

Future<Widget> differentContextDecisionTake() async {
  if (FirebaseAuth.instance.currentUser == null) {
    return const LoginPage();
  }
  else {
    final CloudStoreDataManagement cloudStoreDataManagement =
        CloudStoreDataManagement();
    final bool dataPresentResponse =
        await cloudStoreDataManagement.userRecordPresentOrNot(
            userEmail: FirebaseAuth.instance.currentUser!.email.toString());
    return dataPresentResponse ? const MainScreen() : const TakePrimaryUserData();
  }
}
