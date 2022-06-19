import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final String label;
  final Widget? suffixIcon;
  bool? obscureText;
  bool? autocorrect;
  bool? enableSuggestions;
  TextInputType? keyboardType;
  List<TextInputFormatter>? inputFormatters;
  FocusNode? focusNode;
  VoidCallback? onEditingComplete;
  ValueChanged<String>? onFieldSubmitted;

  AuthTextField({
    Key? key,
    required this.validator,
    required this.controller,
    required this.label,
    Widget? suffixIcon,
    bool? obscureText,
    bool? autocorrect,
    bool? enableSuggestions,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
    FocusNode? focusNode,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onFieldSubmitted,
  })  : suffixIcon = suffixIcon,
        obscureText = obscureText,
        autocorrect = autocorrect,
        enableSuggestions = enableSuggestions,
        keyboardType = keyboardType,
        inputFormatters = inputFormatters,
        focusNode = focusNode,
        onEditingComplete = onEditingComplete,
        onFieldSubmitted = onFieldSubmitted,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        label: Text(label),
        suffixIcon: suffixIcon,
      ),
      autocorrect: autocorrect ?? true,
      enableSuggestions: enableSuggestions ?? true,
      obscureText: obscureText ?? false,
    );
  }
}
