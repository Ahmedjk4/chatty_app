import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.width = 600});
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          Image.asset(
            'assets/logo.png',
            width: MediaQuery.of(context).orientation == Orientation.portrait
                ? 600
                : 120,
          ),
          Text(
            Constants.kAppName,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
