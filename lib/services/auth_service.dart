// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:chat_app/helpers/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final BuildContext context;
  static bool isLoading = false;
  const AuthService(this.context);

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      isLoading = true;
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, 'User not found');
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, 'Wrong password provided for that user.');
      } else if (e.code == 'invalid-credential') {
        showSnackBar(context, 'Invalid email or password.');
      } else if (e.code == 'network-request-failed') {
        showSnackBar(
            context, 'Network error. Please check your internet connection.');
      } else {
        showSnackBar(context, 'Authentication error: ${e.message}');
      }
    } on SocketException {
      showSnackBar(
          context, 'Network error. Please check your internet connection.');
    } catch (e) {
      showSnackBar(
          context,
          'Unexpected error. Please try again later. \n'
          'Error: ${e.toString()}');
    }
    isLoading = false;
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      isLoading = true;
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser?.updatePhotoURL(
          'https://ui-avatars.com/api/?background=random&name=$name&format=png&size=256');
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        showSnackBar(
            context, 'Network error. Please check your internet connection.');
      }
      if (e.code == 'weak-password') {
        showSnackBar(context,
            'Weak password, consider using uppercase and numbers and special characters in the pass.');
      }
      if (e.code == 'email-already-in-use') {
        showSnackBar(context,
            'Email already in use,  if you can\'t remember the password return to login and press forget password.');
      } else {
        showSnackBar(context, 'Sign-up error: ${e.message}');
      }
    } on SocketException {
      showSnackBar(
          context, 'Network error. Please check your internet connection.');
    } catch (e) {
      showSnackBar(
          context,
          'Unexpected error. Please try again later. \n'
          'Error: ${e.toString()}');
    }
    isLoading = false;
  }

  Future<void> resetPassword({required String email}) async {
    try {
      isLoading = true;
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showSnackBar(context, 'Password reset email sent.');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        showSnackBar(
            context, 'Network error. Please check your internet connection.');
      } else {
        showSnackBar(context, 'Reset password error: ${e.message}');
      }
    } on SocketException {
      showSnackBar(
          context, 'Network error. Please check your internet connection.');
    } catch (e) {
      log(e.toString());
      showSnackBar(
          context,
          'Unexpected error. Please try again later. \n'
          'Error: ${e.toString()}');
    }
    isLoading = false;
  }

  Future<void> logOut() async {
    try {
      isLoading = true;
      await FirebaseAuth.instance.signOut();
      showSnackBar(context, 'Successfully logged out.');
    } catch (e) {
      log(e.toString());
      showSnackBar(context, 'Logout error: ${e.toString()}');
    }
    isLoading = false;
  }

  Future<void> updateName(String name) async {
    try {
      isLoading = true;
      await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
      showSnackBar(context, 'Successfully updated name to $name.');
    } catch (e) {
      showSnackBar(context, 'Update name error: ${e.toString()}');
    }
    isLoading = false;
  }
}
