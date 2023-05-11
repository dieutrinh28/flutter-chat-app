import 'package:flutter/material.dart';

import '../res/asset.dart';
import '../res/color.dart';
import '../res/style.dart';
import '../widget/custom_button.dart';
import '../widget/custom_input_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final verifyPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    verifyPasswordController.dispose();
    super.dispose();
  }

  void onGoogleClick() {}
  void onFacebookClick() {}
  void onAppleClick() {}

  void onProceedClick() {
    final isValid = formKey.currentState?.validate();
    if (isValid != null && isValid == true) {
      formKey.currentState?.save();

    }
  }

  void onForgotPasswordClick() {

  }

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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Sign up',
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
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    'Sign up with social media',
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
                  const SizedBox(height: 24),
                  const Text(
                    'or',
                    style: PrimaryFont.textSmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      }
                      if (!RegExp(r"^[a-zA-Z\d.]+@[a-zA-Z\d]+\.[a-zA-Z]+")
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
                  const Text(
                    "Verify password",
                    style: PrimaryFont.subtitleSmallBold,
                  ),
                  const SizedBox(height: 8),
                  InputFieldPassword(
                    controller: verifyPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "this field is required!";
                      }
                      if (value != passwordController.text) {
                        return "confirm password does not match!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: PrimaryButton(
                      name: 'Proceed',
                      onPressed: onProceedClick,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: Column(
                children: [
                  const Text(
                    "Already have an account?",
                    textAlign: TextAlign.center,
                    style: PrimaryFont.textSmall,
                  ),
                  TextButton(
                    onPressed: onForgotPasswordClick,
                    child: Text(
                      "Reset password",
                      textAlign: TextAlign.center,
                      style: PrimaryFont.subtitleSmallBold.copyWith(
                        color: Cl.brandPrimaryBase,
                      ),
                    ),
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
}
