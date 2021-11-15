import 'package:flutter/material.dart';

Widget commonTextFormField({
  required String hintText,
  required String? Function(String?)? validator,
  required TextEditingController textEditingController,
}) {
  return Container(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
    child: TextFormField(
      obscureText: true,
      validator: validator,
      controller: textEditingController,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white70,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.lightBlue,
            width: 2.0,
          ),
        ),
      ),
    ),
  );
}