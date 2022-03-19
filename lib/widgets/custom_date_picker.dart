import 'package:flutter/material.dart';

Future<DateTime?> selectedDate({
  required BuildContext context,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: firstDate ?? DateTime(2020),
      lastDate: lastDate ?? DateTime(3000));
  if (selectedDate != null) {
    return selectedDate;
  } else {
    return null;
  }
}
