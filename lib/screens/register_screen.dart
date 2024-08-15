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

class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController(),
      passController = TextEditingController(),
      firstNameController = TextEditingController(),
      lastNameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.kPrimaryColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is RegisterError) {
            showSnackBar(context, state.error);
          }
          if (state is RegisterSuccess) {
            showSnackBar(context, 'Account created successfully');
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is RegisterLoading,
            child: Form(
              key: formKey,
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
                        controller: firstNameController,
                        label: 'First Name',
                        hintText: 'Enter Your First Name',
                        type: TextFormFieldTypes.name,
                      ),
                      CustomTextField(
                        controller: lastNameController,
                        label: 'Last Name',
                        hintText: 'Enter Your Last Name',
                        type: TextFormFieldTypes.name,
                      ),
                      CustomTextField(
                        controller: emailController,
                        label: 'Email',
                        hintText: 'Enter Your Email',
                        type: TextFormFieldTypes.email,
                      ),
                      CustomTextField(
                        controller: passController,
                        label: 'Password',
                        hintText: 'Enter Your Password Here',
                        obsecure: true,
                        type: TextFormFieldTypes.password,
                      ),
                      CustomButton(
                        text: 'Signup',
                        callback: () async {
                          if (formKey.currentState?.validate() ?? false) {
                            BlocProvider.of<AuthBloc>(context).add(
                              RegisterEvent(
                                name:
                                    " ${firstNameController.text.trim()} ${lastNameController.text.trim()}",
                                email: emailController.text.trim(),
                                password: passController.text.trim(),
                              ),
                            );
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
          );
        },
      ),
    );
  }
}
