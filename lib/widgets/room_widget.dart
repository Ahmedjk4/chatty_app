import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/cubits/change_theme_cubit/cubit/change_theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomWidget extends StatelessWidget {
  final String roomName;
  const RoomWidget({
    super.key,
    required this.roomName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.select<ChangeThemeCubit, Color>(
          (cubit) =>
              cubit.state is LightMode ? Colors.white : const Color(0xFF222E35),
        ),
      ),
      height: 100,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: CachedNetworkImageProvider(
                'https://ui-avatars.com/api/?size=128&name=$roomName',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                roomName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
