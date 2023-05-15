import 'package:chat_app/firebase/auth.dart';
import 'package:chat_app/screen/chat_list.dart';
import 'package:flutter/material.dart';

import '../res/asset.dart';
import '../res/color.dart';
import '../res/style.dart';
import '../widget/custom_button.dart';
import '../widget/custom_input_field.dart';
import 'sign_up.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final EmailAndPasswordAuth emailAndPasswordAuth = EmailAndPasswordAuth();
  final GoogleAuthentication googleAuthentication = GoogleAuthentication();

  bool isHiddenPassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onTogglePasswordVisible() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  void onGoogleClick() async {
    final GoogleSignInResults response = await googleAuthentication.signInWithGoogle();

    String msg = "";

    if (response == GoogleSignInResults.SignInCompleted) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => ChatList()),
              (route) => false);
    } else if (response == GoogleSignInResults.SignInNotCompleted) {
      msg = 'Sign In Not Completed';
    } else if (response == GoogleSignInResults.AlreadySignedIn) {
      msg = 'Already Signed In';
    } else {
      msg = 'Unexpected Error';
    }

    if (msg != '') {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  void onFacebookClick() {}
  void onAppleClick() {}

  void onLoginClick() async {
    final isValid = formKey.currentState?.validate();
    if (isValid != null && isValid == true) {
      formKey.currentState?.save();

      final EmailSignInResults response =
          await emailAndPasswordAuth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      String msg = "";

      if (response == EmailSignInResults.SignInCompleted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => ChatList()),
            (route) => false);
      } else if (response == EmailSignInResults.EmailNotVerified) {
        msg = 'Email not Verified.\nPlease Verify your email and then Log In';
      } else if (response == EmailSignInResults.EmailOrPasswordInvalid) {
        msg = 'Email And Password Invalid';
      } else {
        msg = 'Sign In Not Completed';
      }

      if (msg != '') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(msg)));
      }
    }
  }

  void onSignUpClick() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpPage()),
    );
  }

  void onForgotPasswordClick() {}

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
            Icons.arrow_back_ios_new,
            color: Cl.grayscaleText,
            size: 24,
          ),
          onPressed: () {},
        ),
        title: const Text(
          'Login',
          style: PrimaryFont.subtitleLargeBold,
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    "Email",
                    style: PrimaryFont.subtitleSmallBold,
                  ),
                  const SizedBox(height: 8),
                  InputFieldNonIcon(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "this field is required!";
                      } else if (!RegExp(
                              r"^[a-zA-Z\d.]+@[a-zA-Z\d]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return "email invalid!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Password",
                    style: PrimaryFont.subtitleSmallBold,
                  ),
                  const SizedBox(height: 8),
                  InputFieldPassword(
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "this field is required!";
                      }
                      if (value.length < 6) {
                        return "password must from 6 chars!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: PrimaryButton(
                      name: 'Login',
                      onPressed: onLoginClick,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  const Text(
                    'or social login',
                    textAlign: TextAlign.center,
                    style: PrimaryFont.textSmall,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildSocialButton(
                        image: Id.google,
                        onPressed: onGoogleClick,
                      ),
                      const SizedBox(width: 24),
                      buildSocialButton(
                        image: Id.facebook,
                        onPressed: onFacebookClick,
                      ),
                      const SizedBox(width: 24),
                      buildSocialButton(
                        image: Id.apple,
                        onPressed: onAppleClick,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  buildRichText(
                    text: 'Don’t have an account?',
                    textBtn: 'Register an account',
                    onPressed: onSignUpClick,
                  ),
                  const SizedBox(height: 24),
                  buildRichText(
                    text: 'Forgot password?',
                    textBtn: 'Reset password',
                    onPressed: onForgotPasswordClick,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSocialButton({
    required String image,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      iconSize: 48,
      onPressed: onPressed,
      icon: Image.asset(
        image,
      ),
    );
  }

  Widget buildRichText({
    required String text,
    required String textBtn,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: PrimaryFont.textSmall,
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            textBtn,
            textAlign: TextAlign.center,
            style: PrimaryFont.subtitleSmallBold.copyWith(
              color: Cl.brandPrimaryBase,
            ),
          ),
        ),
      ],
    );
  }
}
