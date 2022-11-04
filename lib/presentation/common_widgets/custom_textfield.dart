import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextEntry extends StatefulWidget {
  final Color entryBackground;
  final double cornerRadius;
  final Color unfocusedBorderColor;
  final double titleSize;
  final Color focusedBorderColor;
  final String labelText;
  final String entryTitle;
  final double labelTextSize;
  final String hintText;
  final void Function()? tapped;
  final void Function()? finished;
  final Color labelColor;
  final Color floatingLabelColor;
  final Color titleColor;
  final FontWeight? fontWeight;
  final TextInputType keyboardType;
  final IconButton? suffIcon;
  final bool isPassword;
  final bool isAvenir;
  final FocusNode? focusNode;
  final double? textBoxHeight;
  final bool hasSuffixIcon;
  final TextEditingController? entryController;

  const TextEntry(
      {Key? key,
      this.entryBackground = Colors.grey,
      this.cornerRadius = 12,
      this.keyboardType = TextInputType.none,
      this.isAvenir = false,
      this.focusNode,
      this.textBoxHeight,
      this.entryTitle = "",
      this.unfocusedBorderColor = Colors.grey,
      this.entryController,
      this.focusedBorderColor = Colors.grey,
      this.labelText = "",
      this.labelTextSize = 14,
      this.isPassword = false,
      this.fontWeight,
      this.hasSuffixIcon = false,
      this.titleSize = 10,
      this.titleColor = Colors.grey,
      this.hintText = "",
      this.suffIcon,
      this.labelColor = Colors.black,
      this.floatingLabelColor = Colors.black,
      this.tapped,
      this.finished})
      : super(key: key);

  @override
  State<TextEntry> createState() => _TextEntryState();
}

class _TextEntryState extends State<TextEntry> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.entryTitle,
          textAlign: TextAlign.start,
          style: TextStyle(
              fontWeight: widget.fontWeight ?? FontWeight.bold,
              fontFamily: "Avenir",
              color: widget.titleColor,
              fontSize: widget.titleSize),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          controller: widget.entryController,
          autofocus: false,
          style: widget.isAvenir
              ? TextStyle(
                  color: Colors.grey,
                  fontFamily: "Avenir",
                  fontSize: widget.labelTextSize)
              : TextStyle(
                  color: widget.labelColor, fontSize: widget.labelTextSize),
          onTap: widget.tapped,
          keyboardType: widget.keyboardType,
          focusNode: widget.focusNode,
          onEditingComplete: widget.finished,
          obscureText: widget.isPassword,
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: EdgeInsets.symmetric(
                  vertical: widget.textBoxHeight ?? 15, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: widget.unfocusedBorderColor),
                  borderRadius:
                      BorderRadius.all(Radius.circular(widget.cornerRadius))),
              fillColor: widget.entryBackground,
              filled: true,
              hintText: widget.hintText,
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: widget.focusedBorderColor, width: 2),
                  borderRadius:
                      BorderRadius.all(Radius.circular(widget.cornerRadius))),
              labelText: widget.labelText,
              labelStyle: widget.isAvenir
                  ? TextStyle(
                      color: widget.labelColor,
                      fontFamily: "Avenir",
                      fontSize: widget.labelTextSize)
                  : TextStyle(
                      color: widget.labelColor, fontSize: widget.labelTextSize),
              floatingLabelStyle: TextStyle(color: widget.floatingLabelColor),
              suffixIcon: widget.hasSuffixIcon
                  ? widget.suffIcon
                  : const SizedBox(
                      width: 1,
                      height: 1,
                    )),
        ),
      ],
    );
  }
}
