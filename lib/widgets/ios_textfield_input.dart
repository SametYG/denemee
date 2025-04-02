import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IosTextfieldInput extends StatelessWidget {
  const IosTextfieldInput({super.key, required this.textEditingController, required this.isPass, required this.hinText, required this.textInputType});
  final TextEditingController textEditingController;
  final bool isPass;
  final String hinText;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: textEditingController,
      obscureText: isPass,
      placeholder: hinText,
      padding: const EdgeInsets.all(8),
      keyboardType: textInputType,
    );
  }
}