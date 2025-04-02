import 'package:flutter/material.dart';

class AndroidTextfieldInput extends StatelessWidget {
  const AndroidTextfieldInput({super.key, required this.textEditingController, required this.isPass, required this.hinText, required this.textInputType});
  final TextEditingController textEditingController;
  final bool isPass;
  final String hinText;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        fillColor: Theme.of(context).colorScheme.onPrimary,
        filled: true,
        labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          backgroundColor: Colors.white
        ),
        labelText: hinText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        contentPadding: const EdgeInsets.all(8),
        floatingLabelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.white,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      ),
      style: TextStyle(color: Theme.of(context).colorScheme.primary),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}