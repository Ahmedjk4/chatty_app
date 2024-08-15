import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/change_theme_cubit/cubit/change_theme_cubit.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/chat_input.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var roomId = ModalRoute.of(context)!.settings.arguments.toString();
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
          BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              if (state is ChatError) {
                return const Expanded(
                    child: Center(
                        child: Text(
                  'Something went wrong',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )));
              }
              if (state is ChatLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ChatSuccess) {
                return Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      var message = state.messages[index];
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
              }

              return const Spacer();
            },
          ),
          ChatInput(
            roomId: roomId.toString(),
          ),
        ],
      ),
    );
  }
}
