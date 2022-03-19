import 'package:flutter/material.dart';

Future actionDialog({
  required BuildContext context,
  required List<ActionItem> actions,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        children: actions
            .map(
              (e) => ListTile(
                leading: e.icon != null ? Icon(e.icon) : null,
                onTap: e.onPressed,
                title: Text(e.title),
              ),
            )
            .toList(),
      );
    },
  );
}

class ActionItem {
  String title;
  VoidCallback onPressed;
  IconData? icon;

  ActionItem({
    this.icon,
    required this.title,
    required this.onPressed,
  });
}
