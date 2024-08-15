import 'dart:developer';
import 'package:chat_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/helpers/showSnackBar.dart';
import 'package:chat_app/types/text_form_field_types.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:chat_app/widgets/logo.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginError) {
          showSnackBar(context, state.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Constants.kPrimaryColor,
          body: ModalProgressHUD(
            inAsyncCall: state is LoginLoading,
            child: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AppLogo(),
                      const SizedBox(
                          height: 20), // Added spacing for better layout
                      const Text(
                        'Login With Existing Account',
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(
                          height: 20), // Added spacing for better layout
                      CustomTextField(
                        controller: emailController,
                        label: 'Email',
                        hintText: 'Enter Your Email',
                        autoFocus: true,
                        type: TextFormFieldTypes.email,
                      ),
                      const SizedBox(
                          height: 20), // Added spacing for better layout
                      CustomTextField(
                        controller: passController,
                        label: 'Password',
                        hintText: 'Enter Your Password Here',
                        obsecure: true, // Correct property name
                        type: TextFormFieldTypes.password,
                      ),
                      const SizedBox(
                          height: 20), // Added spacing for better layout
                      CustomButton(
                        text: 'Login',
                        callback: () async {
                          if (formKey.currentState?.validate() ?? false) {
                            BlocProvider.of<AuthBloc>(context).add(LoginEvent(
                                email: emailController.text,
                                password: passController.text));
                          } else {
                            log('Unsuccessful validation');
                          }
                        },
                      ),
                      const SizedBox(
                          height: 20), // Added spacing for better layout
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
      },
    );
  }
}
