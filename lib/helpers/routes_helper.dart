import 'package:chat_app/screens/change_name_screen.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/no_internet_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/screens/splash_screen.dart';
import 'package:chat_app/widgets/control_flow.dart';
import 'package:flutter/material.dart';

Route<dynamic>? appRoutes(settings) {
  if (settings.name == '/login') {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
      reverseTransitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, widgetTo) =>
          FadeTransition(opacity: animation, child: widgetTo),
    );
  }
  if (settings.name == '/register') {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => RegisterScreen(),
      reverseTransitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, widgetTo) =>
          FadeTransition(opacity: animation, child: widgetTo),
    );
  }
  if (settings.name == '/splash') {
    return MaterialPageRoute(
      builder: (context) {
        return const SplashScreen();
      },
    );
  }
  if (settings.name == '/controlFlow') {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) =>
          const ControlFlow(),
      transitionsBuilder: (context, animation, secondaryAnimation, widgetTo) =>
          FadeTransition(opacity: animation, child: widgetTo),
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 500),
    );
  }
  if (settings.name == '/noInternet') {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) =>
          const NoInternetScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, widgetTo) =>
          FadeTransition(opacity: animation, child: widgetTo),
      reverseTransitionDuration: const Duration(milliseconds: 500),
      transitionDuration: const Duration(milliseconds: 500),
    );
  }
  if (settings.name == '/chatScreen') {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) =>
          const ChatScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, widgetTo) =>
          FadeTransition(opacity: animation, child: widgetTo),
      reverseTransitionDuration: const Duration(milliseconds: 200),
      transitionDuration: const Duration(milliseconds: 200),
    );
  }
  if (settings.name == '/changeName') {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) =>
          const ChangeNameScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, widgetTo) =>
          FadeTransition(opacity: animation, child: widgetTo),
      reverseTransitionDuration: const Duration(milliseconds: 200),
      transitionDuration: const Duration(milliseconds: 200),
    );
  }
  return null;
}
