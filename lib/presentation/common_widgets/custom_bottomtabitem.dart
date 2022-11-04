import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class CustomTabItem extends StatefulWidget {
  CustomTabItem({
    Key? key,
    this.onTap,
    this.text,
    this.largeText = false,
    this.iconWidth,
    required this.assignedIndex,
    this.iconSize,
    this.selectedIconPath,
    this.iconData,
    this.defaultIconPath,
    this.selectedColor,
    this.unSelectedColor,
    required this.selectedIndex,
  })  : isSelected = (selectedIndex == assignedIndex),
        super(key: key);
  int? assignedIndex, selectedIndex;
  double? iconSize, iconWidth;
  final void Function()? onTap;
  String? text, defaultIconPath, selectedIconPath;
  final bool? largeText, isSelected;
  IconData? iconData;
  Color? selectedColor, unSelectedColor;
  @override
  State<CustomTabItem> createState() => _CustomTabItemState();
}

class _CustomTabItemState extends State<CustomTabItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            widget.iconData,
            size: widget.iconSize,
            color: widget.isSelected!
                ? widget.selectedColor
                : widget.unSelectedColor,
          ),
          // Image.asset(
          //   widget.isSelected!
          //       ? widget.selectedIconPath!
          //       : widget.defaultIconPath!,
          //   height: widget.iconSize ?? 24,
          //   width: widget.iconWidth ?? 24,
          //   color: widget.isSelected!
          //       ? widget.selectedColor
          //       : widget.unSelectedColor,
          // ),
          const SizedBox(
            height: 2,
          ),
          Text(widget.text ?? "Home",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: widget.largeText! ? 12 : 14,
                  color: widget.isSelected!
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).unselectedWidgetColor,
                ),
              )),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 3,
            width: widget.selectedIndex == 2 ? 50 : 50,
            decoration: BoxDecoration(
                color: widget.isSelected!
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).unselectedWidgetColor,
                borderRadius: BorderRadius.circular(20)),
          )
        ],
      ),
    );
  }
}
