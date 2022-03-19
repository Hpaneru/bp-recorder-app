import 'package:flutter/material.dart';

class CustomKeyValueCard extends StatelessWidget {
  final String keyValue;
  final String value;
  final VoidCallback? onTap;

  const CustomKeyValueCard({
    Key? key,
    required this.keyValue,
    required this.value,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: ListTile(
        dense: false,
        title: Text(keyValue),
        trailing: SelectableText(value),
      ),
    );
  }
}
