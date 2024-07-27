// ignore_for_file: file_names
import 'dart:developer';
import 'package:flutter/material.dart';

Future<dynamic> displayInputDialog(
    BuildContext context, TextEditingController textFieldController,
    {VoidCallback? callback}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create New Room'),
          content: TextField(
            controller: textFieldController,
            decoration: const InputDecoration(hintText: "Room Name"),
          ),
          actions: <Widget>[
            MaterialButton(
              child: const Text('CANCEL'),
              onPressed: () {
                log('\u001b[31mCancel Pressed');
                Navigator.pop(context);
              },
            ),
            MaterialButton(
              onPressed: callback ??
                  () {
                    log('Creating New Room');
                    Navigator.pop(context);
                  },
              child: const Text('Confirm'),
            ),
          ],
        );
      });
}
