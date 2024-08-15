import 'dart:developer';
import 'package:avatars/avatars.dart';
import 'package:chat_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/cubits/change_theme_cubit/cubit/change_theme_cubit.dart';
import 'package:chat_app/helpers/showSnackBar.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UpdateNameSuccess) {
          showSnackBar(context, 'Changed Name To ${state.newName}');
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: state is LogoutLoading,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Avatar(
                  shape: AvatarShape.circle(72),
                  useCache: true,
                  name: FirebaseAuth.instance.currentUser?.displayName ??
                      "No Name",
                  placeholderColors: const [
                    Colors.blue,
                    Colors.green,
                  ],
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
                    BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ToggleSwitch(
                  minWidth: 90.0,
                  minHeight: 70.0,
                  initialLabelIndex:
                      context.select<ChangeThemeCubit, int>((cubit) {
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
                    BlocProvider.of<ChangeThemeCubit>(context)
                        .changeTheme(index);
                    log('switched to: $index');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
