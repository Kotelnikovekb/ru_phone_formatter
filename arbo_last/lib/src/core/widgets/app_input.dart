import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppInput extends StatelessWidget {
  final Widget? label;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;

  const AppInput(
      {Key? key,
      this.controller,
      this.validator,
      this.label,
      this.suffixIcon,
      this.inputFormatters,
      this.keyboardType,
      this.textInputAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        label: label,
        contentPadding: const EdgeInsets.all(15),
        suffixIcon: suffixIcon
      ),
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      textInputAction: textInputAction,

    );
  }
}

