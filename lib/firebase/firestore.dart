import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';

class CloudStoreDataManagement {
  final collectionName = 'generation_users';

  Future<bool> checkThisUserAlreadyPresentOrNot({
    required String userName,
  }) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> findResults =
          await FirebaseFirestore.instance
              .collection(collectionName)
              .where("user_name", isEqualTo: userName)
              .get();
      return findResults.docs.isNotEmpty ? true : false;
    } catch (e) {
      print('Error in Check This User Already Present Or Not: ${e.toString()}');
      return false;
    }
  }

  Future<bool> registerNewUser({
    required String userName,
    required String userAbout,
    required String userEmail,
  }) async {
    try {
      final String? getToken = await FirebaseMessaging.instance.getToken();

      final String currentDate =
          DateFormat('dd-MM-yyyy').format(DateTime.now());

      final String currentTime =
          "${DateFormat('hh:mm a').format(DateTime.now())}";

      await FirebaseFirestore.instance.doc('$collectionName/$userEmail').set({
        "about": userAbout,
        "user_name": userName,
        "creation_date": currentDate,
        "creation_time": currentTime,
        "token": getToken,
        "phone_number": "",
        "profile_pic": "",
      });

      return true;
    } catch (e) {
      print('Error in Register new user: ${e.toString()}');
      return false;
    }
  }

  Future<bool> userRecordPresentOrNot({required String userEmail}) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .doc('$collectionName/$userEmail')
              .get();
      return documentSnapshot.exists;
    } catch (e) {
      print('Error in User Record Present or Not: ${e.toString()}');
      return false;
    }
  }


}
