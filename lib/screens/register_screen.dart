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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static final TextEditingController emailController = TextEditingController(),
      passController = TextEditingController(),
      firstNameController = TextEditingController(),
      lastNameController = TextEditingController();
  static final GlobalKey<FormState> formKey = GlobalKey();

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.kPrimaryColor,
      body: ModalProgressHUD(
        inAsyncCall: AuthService.isLoading,
        child: Form(
          key: RegisterScreen.formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppLogo(),
                  const Text(
                    'Create New Account',
                    style: TextStyle(fontSize: 24),
                  ),
                  CustomTextField(
                    autoFocus: true,
                    controller: RegisterScreen.firstNameController,
                    label: 'First Name',
                    hintText: 'Enter Your First Name',
                    type: TextFormFieldTypes.name,
                  ),
                  CustomTextField(
                    controller: RegisterScreen.lastNameController,
                    label: 'Last Name',
                    hintText: 'Enter Your Last Name',
                    type: TextFormFieldTypes.name,
                  ),
                  CustomTextField(
                    controller: RegisterScreen.emailController,
                    label: 'Email',
                    hintText: 'Enter Your Email',
                    type: TextFormFieldTypes.email,
                  ),
                  CustomTextField(
                    controller: RegisterScreen.passController,
                    label: 'Password',
                    hintText: 'Enter Your Password Here',
                    obsecure: true,
                    type: TextFormFieldTypes.password,
                  ),
                  CustomButton(
                    text: 'Signup',
                    callback: () async {
                      if (RegisterScreen.formKey.currentState?.validate() ??
                          false) {
                        setState(() {});
                        await AuthService(context).signUp(
                            name:
                                '${RegisterScreen.firstNameController.text} ${RegisterScreen.lastNameController.text}',
                            email: RegisterScreen.emailController.text,
                            password: RegisterScreen.passController.text);
                        if (mounted) {
                          setState(() {});
                        }
                      } else {
                        log('Unsuccessful login');
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Already have one ?',
                          style: TextStyle(fontSize: 18),
                        ),
                        TextSpan(
                          text: ' Return to login',
                          style: TextStyle(
                            color: Colors.blue.shade500,
                            fontSize: 18,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              log('Pop To Login Page');
                              Navigator.pop(context);
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
