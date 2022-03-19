import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final bool shadow, border;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color? color, borderColor;
  final bool borderRadius;
  final double? height;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final AlignmentGeometry? alignment;

  const CustomContainer({
    Key? key,
    required this.child,
    this.shadow = false,
    this.border = false,
    this.borderRadius = true,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(8.0),
    this.color,
    this.borderColor,
    this.height,
    this.onTap,
    this.onLongPress,
    this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        // width: width,
        alignment: alignment,
        height: height,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: borderRadius
                ? const BorderRadius.all(Radius.circular(10))
                : BorderRadius.zero,
            // border: border
            //     ? Border.all(
            //         // color: borderColor ?? Get.theme.primaryColor, width: 1.5)
            //     : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                spreadRadius: 6,
                blurRadius: 6,
                offset: const Offset(4, 4),
              )
            ]),
        child: child,
      ),
    );
  }
}
