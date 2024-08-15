import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/rooms_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ControlFlow extends StatelessWidget {
  const ControlFlow({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const RoomsScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
