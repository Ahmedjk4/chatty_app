import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkForInternetAndNavigate(context);
  }

  Future<void> checkForInternetAndNavigate(BuildContext context) async {
    try {
      final response = await http
          .get(Uri.parse('https://www.google.com'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        log('Connected to Internet: true');
        Future.delayed(const Duration(seconds: 4, milliseconds: 200), () {
          if (mounted) {
            Navigator.pushReplacementNamed(context, '/controlFlow');
          }
        });
      } else {
        throw const SocketException('Failed to load Google homepage');
      }
    } on SocketException catch (e) {
      log('SocketException: ${e.toString()}', name: 'Splash Screen');
      Future.delayed(const Duration(seconds: 4, milliseconds: 200), () {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/noInternet');
        }
      });
    } on TimeoutException catch (e) {
      log('TimeoutException: ${e.toString()}', name: 'Splash Screen');
      Future.delayed(const Duration(seconds: 4, milliseconds: 200), () {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/noInternet');
        }
      });
    } catch (e) {
      log('Exception: ${e.toString()}', name: 'Splash Screen');
      Future.delayed(const Duration(seconds: 4, milliseconds: 200), () {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/noInternet');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF278FEE),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Lottie.asset(
                'assets/splashAnimation.json',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
