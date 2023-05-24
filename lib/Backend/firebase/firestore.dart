import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';

class CloudStoreDataManagement {
  final collectionName = 'generation_users';

  Future<bool> checkUserNameAlreadyPresentOrNot({
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
        "activity": [],
        "connections": {},
        "connection_request": [],
        "total_connections": "",
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

  /*Future<List<Map<String, dynamic>>> getUsersExceptMe({
    required String currentUserEmail
}) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection(collectionName).get();

      List<Map<String, dynamic>> userDataCollection = [];

      querySnapshot.docs.forEach((QueryDocumentSnapshot<Map<String, dynamic>> queryDocumentSnapshot) {
        if (currentUserEmail != queryDocumentSnapshot.id) {
         userDataCollection.add({queryDocumentSnapshot.id: });
        }
      });

    } catch (e) {
      print('Error in get all user list except my account: ${e.toString()}');
      return [];
    }
  }*/
}
