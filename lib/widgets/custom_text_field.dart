import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.hintText,
    this.controller,
    required this.label,
    this.validator,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.maxLine = 1,
    this.initialValue,
    this.suffix,
    this.prefix,
    this.inputFormatters,
    this.onSaved,
    this.keyboardType,
  }) : super(key: key);

  final TextEditingController? controller;
  final String label;
  final String? hintText, initialValue;
  final String? Function(String?)? validator;
  final bool obscureText, readOnly;
  final Function()? onTap;
  final Widget? suffix, prefix;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLine;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: keyboardType,
        initialValue: initialValue,
        controller: controller,
        readOnly: readOnly,
        maxLines: maxLine,
        onTap: onTap,
        autocorrect: false,
        obscureText: obscureText,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: const OutlineInputBorder(),
          suffix: suffix,
          prefix: prefix,
        ),
        onChanged: onChanged,
        onSaved: onSaved,
        validator: validator,
      ),
    );
  }
}

class LowerCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

class PressureDataFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

class CustomBloodPressureDataFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 3 == 0 && nonZeroIndex != text.length) {
        buffer.write(
            '/'); // Replace this with anything you want to put after each 4 numbers
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
