import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatInput extends StatelessWidget {
  final String roomId;
  final TextEditingController controller = TextEditingController();
  ChatInput({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Type a message',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(controller.text);
                controller.clear();
              },
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton.filled(
            onPressed: () {
              BlocProvider.of<ChatCubit>(context).sendMessage(controller.text);
              controller.clear();
            },
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
