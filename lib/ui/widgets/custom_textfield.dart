import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class CustomField extends StatelessWidget {
  final String labelText;
  final bool hideText;
  final TextEditingController controller;

  const CustomField({
    Key? key,
    required this.labelText,
    this.hideText = false,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextField(
        controller: controller,
        obscureText: hideText,
        cursorColor: blueC,
        decoration: InputDecoration(
          labelText: labelText,
          focusColor: whiteC,
          fillColor: whiteC,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: blueC,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: greyC,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }
}
