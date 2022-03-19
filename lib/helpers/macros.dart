import 'package:flutter/material.dart';

void customSnackbar({required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: const Color(0xffE5E5E5),
    content: Text(message, style: const TextStyle(color: Colors.black)),
  ));
}
