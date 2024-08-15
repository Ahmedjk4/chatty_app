import 'dart:developer';
import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/change_theme_cubit/cubit/change_theme_cubit.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/helpers/displayInputDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../widgets/room_widget.dart';

class RoomsView extends StatefulWidget {
  const RoomsView({super.key});
  static final TextEditingController _controller = TextEditingController();

  @override
  State<RoomsView> createState() => _RoomsViewState();
}

class _RoomsViewState extends State<RoomsView> {
  List<String> rooms = Hive.box('rooms').get('rooms', defaultValue: <String>[]);
  @override
  void dispose() {
    log('RoomsView Disposed');
    var box = Hive.box('rooms');
    box.put('rooms', rooms);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.select<ChangeThemeCubit, Color>(
        (cubit) => cubit.state is LightMode
            ? Constants.kPrimaryColor
            : Constants.kPrimaryColor,
      ),
      appBar: AppBar(
        title: const Text('Rooms'),
        backgroundColor: context.select<ChangeThemeCubit, Color>(
          (cubit) => cubit.state is LightMode ? Colors.white : Colors.black,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Dismissible(
            background: Container(color: Colors.red),
            key: Key(rooms[index]),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                rooms.removeAt(index);
                var box = Hive.box('rooms');
                box.put('rooms', rooms);
              });
            },
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<ChatCubit>(context).getChat(rooms[index]);
                Navigator.pushNamed(context, '/chatScreen',
                    arguments: rooms[index]);
              },
              child: RoomWidget(
                roomName: rooms[index],
              ),
            ),
          );
        },
        itemCount: rooms.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          log('Open Input Dialog');
          await DisplayInputDialog.display(
            context,
            callback: () {
              log('Creating New Room');
              setState(() {
                rooms.add(DisplayInputDialog.controller.text);
              });
              Navigator.pop(context);
              var box = Hive.box('rooms');
              box.put('rooms', rooms);
            },
          );
          log(RoomsView._controller.text);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
