import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.loading = false,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String label;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      alignment: Alignment.center,
      child: AnimatedCrossFade(
        duration: const Duration(milliseconds: 200),
        firstChild: ElevatedButton(
          child: Text(label),
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
              const Size(double.infinity, 50),
            ),
            textStyle: MaterialStateProperty.all(
              Theme.of(context).textTheme.button?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
            ),
          ),
          onPressed: () {
            FocusScope.of(context).unfocus();
            onPressed();
          },
        ),
        secondChild: Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.all(8.0),
          child: loading
              ? const CircularProgressIndicator(strokeWidth: 2)
              : const SizedBox(),
        ),
        crossFadeState:
            loading ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      ),
    );
  }
}
