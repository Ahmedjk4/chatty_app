// ignore_for_file: file_names
import 'dart:developer';
import 'package:flutter/material.dart';

class DisplayInputDialog {
  static final TextEditingController controller = TextEditingController();
  static Future<void> display(BuildContext context, {Function()? callback}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Create New Room'),
            content: TextField(
              controller: DisplayInputDialog.controller,
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
}
