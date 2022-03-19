import 'package:flutter/material.dart';

mixin LoadinMixin<T extends StatefulWidget> on State<T> {
  bool loading = false;
  setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }
}
