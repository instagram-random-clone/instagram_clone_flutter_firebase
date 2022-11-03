import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPassword;
  final String hintText;
  final TextInputType textInputType;

  const TextFieldInput({
    super.key,
    required this.hintText,
    required this.textEditingController,
    required this.textInputType,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));

    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          contentPadding: const EdgeInsets.all(8.0),
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder),
      keyboardType: textInputType,
      obscureText: isPassword,
    );
  }
}
