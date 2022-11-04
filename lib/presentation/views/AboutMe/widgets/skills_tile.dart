import 'package:flutter/material.dart';
import 'package:portfolio_app/presentation/views/AboutMe/widgets/skills_widget.dart';

class SkillsTile extends StatelessWidget {
  const SkillsTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "SKILLS",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        SizedBox(
          height: 180,
          width: double.infinity,
          child: Stack(
            children: [
              SkillsWidget(
                isFirstSequence: true,
                title: "Dart",
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: SkillsWidget(
                    isFirstSequence: false,
                    title: "C#",
                  )),
              Align(
                  alignment: Alignment.topRight,
                  child: SkillsWidget(
                    isFirstSequence: true,
                    title: "MVVM",
                  )),
              Positioned(
                bottom: 0,
                left: 60,
                child: SkillsWidget(
                  isFirstSequence: false,
                  title: "ASP .NET",
                ),
              ),
              Positioned(
                bottom: 0,
                right: 60,
                child: SkillsWidget(
                  isFirstSequence: true,
                  title: "API",
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
