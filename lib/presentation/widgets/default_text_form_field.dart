import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.errorMsg,
    this.inputAction,
    this.inputType,
  });

  final TextEditingController controller;
  final String hintText;
  final String errorMsg;
  final TextInputAction? inputAction;
  final TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (val) => val!.isEmpty ? errorMsg : null,
      autocorrect: false,
      textInputAction: inputAction ?? TextInputAction.next,
      keyboardType: inputType ?? TextInputType.text,
      decoration: InputDecoration(hintText: hintText),
    );
  }
}
