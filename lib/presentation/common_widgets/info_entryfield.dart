import 'package:flutter/material.dart';

import 'custom_textfield.dart';

class InfoEntryField extends StatefulWidget {
  const InfoEntryField(
      {Key? key,
      this.entryTitle,
      this.controller,
      this.labelText,
      this.iconData,
      this.titleColor,
      this.fontWeight,
      this.hasIcon = true,
      this.iconColor,
      this.focusNode,
      this.focusedBorderColor,
      this.unfocusedBorderColor,
      this.textBoxHeight,
      this.entryBackground,
      this.isPassword = false,
      this.onPressed})
      : super(key: key);
  final String? entryTitle, labelText;
  final IconData? iconData;
  final void Function()? onPressed;
  final Color? titleColor,
      entryBackground,
      focusedBorderColor,
      iconColor,
      unfocusedBorderColor;
  final bool? isPassword;
  final bool? hasIcon;
  final FontWeight? fontWeight;
  final double? textBoxHeight;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  @override
  State<InfoEntryField> createState() => _InfoEntryFieldState();
}

class _InfoEntryFieldState extends State<InfoEntryField> {
  @override
  Widget build(BuildContext context) {
    return TextEntry(
      entryTitle: widget.entryTitle ?? "",
      titleColor: widget.titleColor ?? Colors.grey,
      titleSize: 14,
      entryController: widget.controller,
      fontWeight: widget.fontWeight ?? FontWeight.bold,
      cornerRadius: 6,
      isAvenir: true,
      focusNode: widget.focusNode,
      textBoxHeight: widget.textBoxHeight,
      isPassword: widget.isPassword!,
      focusedBorderColor: widget.focusedBorderColor ?? Colors.grey,
      unfocusedBorderColor: widget.unfocusedBorderColor ?? Colors.transparent,
      labelText: widget.labelText ?? "",
      labelColor: Colors.grey,
      entryBackground: widget.entryBackground ?? Colors.transparent,
      keyboardType: TextInputType.text,
      hasSuffixIcon: widget.hasIcon ?? true,
      suffIcon: IconButton(
        onPressed: widget.onPressed ?? () {},
        splashRadius: 1,
        icon: Icon(
          widget.iconData ?? Icons.email_outlined,
          color: widget.iconColor ?? Colors.grey,
        ),
      ),
    );
  }
}
