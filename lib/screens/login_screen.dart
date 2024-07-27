import 'dart:developer';
import 'package:chat_app/constants.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/types/text_form_field_types.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:chat_app/widgets/logo.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passController = TextEditingController();
  static final GlobalKey<FormState> formKey =
      GlobalKey<FormState>(); // Ensure FormState is used

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.kPrimaryColor,
      body: ModalProgressHUD(
        inAsyncCall: AuthService.isLoading,
        child: Form(
          key: LoginScreen.formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppLogo(),
                  const SizedBox(height: 20), // Added spacing for better layout
                  const Text(
                    'Login With Existing Account',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20), // Added spacing for better layout
                  CustomTextField(
                    controller: LoginScreen.emailController,
                    label: 'Email',
                    hintText: 'Enter Your Email',
                    autoFocus: true,
                    type: TextFormFieldTypes.email,
                  ),
                  const SizedBox(height: 20), // Added spacing for better layout
                  CustomTextField(
                    controller: LoginScreen.passController,
                    label: 'Password',
                    hintText: 'Enter Your Password Here',
                    obsecure: true, // Correct property name
                    type: TextFormFieldTypes.password,
                  ),
                  const SizedBox(height: 20), // Added spacing for better layout
                  CustomButton(
                    text: 'Login',
                    callback: () async {
                      if (LoginScreen.formKey.currentState?.validate() ??
                          false) {
                        setState(() {});
                        await AuthService(context).signIn(
                            email: LoginScreen.emailController.text,
                            password: LoginScreen.passController.text);
                        if (mounted) {
                          setState(() {});
                        }
                        log('Success validation');
                      } else {
                        log('Unsuccessful validation');
                      }
                    },
                  ),
                  const SizedBox(height: 20), // Added spacing for better layout
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Don\'t have an account? ',
                          style: TextStyle(fontSize: 18),
                        ),
                        TextSpan(
                          text: 'Create one now',
                          style: TextStyle(
                            color: Colors.blue.shade500,
                            fontSize: 18,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              log('Navigate to Register Page');
                              Navigator.pushNamed(context, '/register');
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
