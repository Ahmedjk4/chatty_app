import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/cubits/change_theme_cubit/cubit/change_theme_cubit.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 75,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl: FirebaseAuth.instance.currentUser!.photoURL!,
                  height: 256,
                  width: 256,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(FirebaseAuth.instance.currentUser?.displayName ??
                "Name Not Updated Yet, Try Restarting The App"),
            const SizedBox(
              height: 50,
            ),
            CustomButton(
              text: 'Change Name',
              callback: () {
                Navigator.pushNamed(context, '/changeName');
              },
            ),
            CustomButton(
              text: 'Logout',
              callback: () async {
                await AuthService(context).logOut();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ToggleSwitch(
              minWidth: 90.0,
              minHeight: 70.0,
              initialLabelIndex: context.select<ChangeThemeCubit, int>((cubit) {
                if (cubit.state is LightMode) {
                  return 0;
                } else {
                  return 1;
                }
              }),
              cornerRadius: 20.0,
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              totalSwitches: 2,
              icons: const [
                Icons.sunny,
                Icons.dark_mode,
              ],
              iconSize: 30.0,
              activeBgColors: const [
                [Colors.yellow, Colors.orange],
                [Colors.black45, Colors.black26],
              ],
              animate: true,
              onToggle: (index) {
                BlocProvider.of<ChangeThemeCubit>(context).changeTheme(index);
                log('switched to: $index');
              },
            ),
          ],
        ),
      ),
    );
  }
}
