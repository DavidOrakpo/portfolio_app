import 'package:flutter/material.dart';
import 'package:portfolio_app/core/enums/enum.dart';

class ExperienceTile extends StatelessWidget {
  ExperienceTile({
    Key? key,
    // this.date,
    required this.company,
    this.onTap,
    this.imagePath,
    this.backgroudColor,
  })  : date = company!.date,
        title = company.jobPosition,
        super(key: key);
  final String? title, imagePath, date;
  final void Function()? onTap;
  final Color? backgroudColor;
  final Companies? company;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 246,
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.primaryContainer,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.25),
              blurRadius: 15,
              spreadRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                color: backgroudColor ?? Colors.black,
                child: Image.asset(
                  imagePath ?? "assets/images/heckerbella.png",
                  fit: BoxFit.fitWidth,
                  height: 170,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title ?? "Junior Flutter Developer",
              style: TextStyle(
                  fontSize: 20, color: Theme.of(context).primaryColor),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              date ?? "April 2022 - Present",
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context)
                    .colorScheme
                    .onPrimaryContainer
                    .withOpacity(0.6),
              ),
            )
          ],
        ),
      ),
    );
  }
}
