import 'package:chat_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/helpers/showSnackBar.dart';
import 'package:chat_app/helpers/startsWithCapitalLetter.dart';
import 'package:chat_app/types/text_form_field_types.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeNameScreen extends StatelessWidget {
  const ChangeNameScreen({super.key});
  static final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.kPrimaryColor,
      appBar: AppBar(),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Change Name',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            CustomTextField(
              hintText: 'Enter The New Name',
              label: 'New Name',
              controller: controller,
              type: TextFormFieldTypes.name,
            ),
            CustomButton(
                text: 'Confirm',
                callback: () async {
                  if (controller.text.isNotEmpty &&
                      controller.text.startsWithCapitalLetter()) {
                    try {
                      BlocProvider.of<AuthBloc>(context)
                          .add(UpdateNameEvent(name: controller.text));
                      controller.clear();
                      Navigator.pop(context);
                    } catch (e) {
                      showSnackBar(context, 'Failed To Change Name');
                      return;
                    }
                  } else if (controller.text.isEmpty) {
                    showSnackBar(context, 'Name Cannot Be Empty');
                  } else if (!controller.text.startsWithCapitalLetter()) {
                    showSnackBar(
                        context, 'Name Should Start With Capital Letter');
                  }
                }),
          ],
        ),
      )),
    );
  }
}
