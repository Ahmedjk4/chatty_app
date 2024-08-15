import 'package:chat_app/types/text_form_field_types.dart';
import 'package:chat_app/helpers/startsWithCapitalLetter.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText, label;
  final bool obsecure, autoFocus;
  final TextEditingController controller;
  final TextFormFieldTypes type;
  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.label,
      this.obsecure = false,
      this.autoFocus = false,
      required this.controller,
      required this.type});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  Color _labelColor = Colors.grey.shade500;
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            setState(() {
              _labelColor = Colors.red;
              _autoValidateMode = AutovalidateMode.always;
            });

            return 'This Field Is Required';
          } else if (widget.type == TextFormFieldTypes.email &&
              !EmailValidator.validate(widget.controller.text)) {
            setState(() {
              _labelColor = Colors.red;
              _autoValidateMode = AutovalidateMode.always;
            });
            return 'Invalid Email';
          } else if (widget.type == TextFormFieldTypes.password &&
              value.length < 8) {
            setState(() {
              _labelColor = Colors.red;
              _autoValidateMode = AutovalidateMode.always;
            });
            return 'Password must be at least 8 characters';
          } else if (widget.type == TextFormFieldTypes.name &&
              value.startsWithCapitalLetter() == false) {
            setState(() {
              _labelColor = Colors.red;
              _autoValidateMode = AutovalidateMode.always;
            });
            return 'Name Must Start With Capital Letter';
          }

          setState(() {
            _labelColor = Colors.grey.shade500;
            _autoValidateMode = AutovalidateMode.always;
          });

          return null;
        },
        controller: widget.controller,
        autovalidateMode: _autoValidateMode,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(2),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF2282BF), width: 3),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 3),
            borderRadius: BorderRadius.circular(2),
          ),
          labelText: widget.label,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.grey.shade800,
          ),
          labelStyle: TextStyle(
            color: _labelColor,
          ),
        ),
        obscureText: widget.obsecure,
        obscuringCharacter: '*',
        autofocus: widget.autoFocus,
      ),
    );
  }
}
