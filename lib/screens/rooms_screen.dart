import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/change_theme_cubit/cubit/change_theme_cubit.dart';
import 'package:chat_app/screens/rooms_screen_page_views/rooms_view.dart';
import 'package:chat_app/screens/rooms_screen_page_views/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.kPrimaryColor,
      body: PageView(
        physics: const ClampingScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        controller: _pageController,
        children: const [
          RoomsView(),
          SettingsView(),
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: context.select<ChangeThemeCubit, Color>(
          (cubit) => cubit.state is LightMode ? Colors.white : Colors.black,
        ),
        curve: Curves.fastEaseInToSlowEaseOut,
        itemPadding: const EdgeInsets.only(left: 16.0),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        selectedIndex: _selectedIndex,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: const Icon(Icons.chat_sharp),
            title: const Text('Rooms'),
            activeColor: Colors.blue,
            inactiveColor: Colors.grey.shade700,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.settings),
            title: const Text('Settings'),
            activeColor: Colors.blue,
            inactiveColor: Colors.grey.shade700,
          ),
        ],
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          });
        },
      ),
    );
  }
}
