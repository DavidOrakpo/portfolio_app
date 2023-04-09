import 'package:flutter/material.dart';
import 'package:portfolio_app/core/enums/enum.dart';
import 'package:portfolio_app/presentation/views/Experience/widgets/experience_tile.dart';

class ExperiencePage extends StatefulWidget {
  ExperiencePage({Key? key}) : super(key: key);

  @override
  State<ExperiencePage> createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 24.0,
              right: 24,
              left: 24,
              bottom: 70,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "EXPERIENCE",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  height: 2,
                  thickness: 1,
                ),
                const SizedBox(
                  height: 24,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: Companies.values.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 24,
                  ),
                  itemBuilder: (context, index) {
                    var item = Companies.values[index];
                    return ExperienceTile(company: item);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
