import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/change_theme_cubit/cubit/change_theme_cubit.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenArguments {
  final String roomId;

  ScreenArguments(this.roomId);
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final roomId = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      backgroundColor: context.select<ChangeThemeCubit, Color>(
        (cubit) =>
            cubit.state is LightMode ? Colors.white : Constants.kPrimaryColor,
      ),
      appBar: AppBar(
        title: Text(roomId.toString()),
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: FirestoreService.firestore
                .collection('rooms')
                .doc(roomId.toString())
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              var roomSnapshot = snapshot.data;
              if (roomSnapshot == null || !roomSnapshot.exists) {
                return const Spacer();
              }
              var messages = roomSnapshot.get('messages');
              return Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    return BubbleSpecialThree(
                      text: message['message'],
                      color: message['emailOfSender'] ==
                              FirebaseAuth.instance.currentUser?.email
                          ? Colors.green
                          : Colors.grey,
                      tail: true,
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 16),
                      isSender: message['emailOfSender'] ==
                              FirebaseAuth.instance.currentUser?.email
                          ? true
                          : false,
                    );
                  },
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) {
                      FirestoreService.sendMessage(
                        msg: _controller.text,
                        roomId: roomId.toString(),
                        time: DateTime.now(),
                        emailOfSender:
                            FirebaseAuth.instance.currentUser!.email!,
                      );
                      _controller.clear();
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton.filled(
                  onPressed: () {
                    FirestoreService.sendMessage(
                      msg: _controller.text,
                      roomId: roomId.toString(),
                      time: DateTime.now(),
                      emailOfSender: FirebaseAuth.instance.currentUser!.email!,
                    );
                    _controller.clear();
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
