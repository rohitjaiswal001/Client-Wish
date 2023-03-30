import 'package:flutter/material.dart';
import 'package:wishwell/form_validator.dart';

class TF extends StatelessWidget {
  const TF({
    Key? key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    required this.suffix,
    this.isPassword,
    this.enabled,
    this.readOnly,
    this.autoFocus,
    this.validator,
    required this.focusNode,
    this.onSaved,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final GestureDetector suffix;
  final bool? isPassword;
  final bool? enabled;
  final bool? readOnly;
  final bool? autoFocus;
  final String? Function(String?)? validator;
  final FocusNode focusNode;
  final Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    final FormValidator formValidator = FormValidator();
    return TextFormField(
        controller: controller,
        validator: formValidator.validateText,
        onSaved: onSaved,
        readOnly: false,
        obscureText: false,
        focusNode: focusNode,
        autofocus: false,
        decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.greenAccent,
                width: 1.0,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            hintText: hintText,
            //helperText: helpText,
            prefixIcon: const Icon(Icons.person_add),
            suffix: suffix,
            enabled: true,
            labelText: hintText

            //errorText: errorText
            ));
  }
}
