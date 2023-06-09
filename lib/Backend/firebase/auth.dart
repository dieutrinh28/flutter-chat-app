import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum EmailSignUpResults {
  SignUpCompleted,
  EmailAlreadyPresent,
  SignUpNotCompleted,
}

enum EmailSignInResults {
  SignInCompleted,
  EmailNotVerified,
  EmailOrPasswordInvalid,
  UnexpectedError,
}

enum GoogleSignInResults {
  SignInCompleted,
  SignInNotCompleted,
  UnexpectedError,
  AlreadySignedIn,
}

class EmailAndPasswordAuth {
  Future<EmailSignUpResults> signUpAuth({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user!.email != null) {
        await userCredential.user!.sendEmailVerification();
        return EmailSignUpResults.SignUpCompleted;
      }
      return EmailSignUpResults.SignUpNotCompleted;
    } catch (e) {
      print('Error in Email and Password Sign Up: ${e.toString()}');
      return EmailSignUpResults.EmailAlreadyPresent;
    }
  }

  Future<EmailSignInResults> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user!.emailVerified) {
        return EmailSignInResults.SignInCompleted;
      }
      else {
        final bool logOutResponse = await logOut();
        if (logOutResponse) {
          return EmailSignInResults.EmailNotVerified;
        }
        return EmailSignInResults.UnexpectedError;
      }
    } catch (e) {
      print('Error in Sign In with Email and Password: ${e.toString()}');
      return EmailSignInResults.EmailOrPasswordInvalid;
    }
  }

  Future<bool> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }
}

class GoogleAuthentication {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<GoogleSignInResults> signInWithGoogle() async {
    try {
      if (await googleSignIn.isSignedIn()) {
        print('Google Sign In Already');
        return GoogleSignInResults.AlreadySignedIn;
      } else {
        final GoogleSignInAccount? googleSignInAccount =
            await googleSignIn.signIn();
        if (googleSignInAccount == null) {
          print('Google Sign In Not Completed');
          return GoogleSignInResults.SignInNotCompleted;
        } else {
          final GoogleSignInAuthentication googleSignInAuth =
              await googleSignInAccount.authentication;
          final OAuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuth.accessToken,
            idToken: googleSignInAuth.idToken,
          );
          final UserCredential userCredential =
              await FirebaseAuth.instance.signInWithCredential(credential);

          if (userCredential.user!.email != null) {
            print('Google Sign In Completed');
            return GoogleSignInResults.SignInCompleted;
          } else {
            print('Google Sign In Problem');
            return GoogleSignInResults.UnexpectedError;
          }
        }
      }
    } catch (e) {
      print('Error in sign in with Google ${e.toString()}');
      return GoogleSignInResults.UnexpectedError;
    }
  }

  Future<bool> logOut() async {
    try {
      print('Google Log Out');

      await googleSignIn.disconnect();
      await googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      print('Error in Sign In with Google');
      return false;
    }
  }
}
