import 'package:flutter/material.dart';

import 'custom_button.dart';

class CustomOutlinedButton extends StatelessWidget {
  CustomOutlinedButton({
    Key? key,
    this.onPressed,
    this.borderColor,
    this.borderWidth,
    this.filled,
    this.fontSize,
    this.fontweight,
    this.isAvenir,
    this.backgroundColor,
    this.width,
    this.text,
    this.textColor,
  }) : super(key: key);
  void Function()? onPressed;
  bool? filled, isAvenir;
  Color? borderColor, textColor, backgroundColor;
  double? borderWidth, fontSize, width;
  String? text;
  FontWeight? fontweight;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      width: width ?? double.infinity,
      filled: false,
      backgroundColor: backgroundColor ?? Colors.transparent,
      onPressed: onPressed ?? () {},
      borderColor: borderColor ?? Colors.grey,
      borderWidth: borderWidth ?? 2,
      text: text ?? "No, I decline",
      textColor: textColor ?? Colors.grey,
      fontSize: fontSize ?? 16,
      fontweight: fontweight ?? FontWeight.bold,
      isAvenir: isAvenir ?? true,
    );
  }
}
