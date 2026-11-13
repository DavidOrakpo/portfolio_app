import 'package:material_ui/material_ui.dart';

import 'custom_button.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
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
  });
  final void Function()? onPressed;
  final bool? filled, isAvenir;
  final Color? borderColor, textColor, backgroundColor;
  final double? borderWidth, fontSize, width;
  final String? text;
  final FontWeight? fontweight;

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
