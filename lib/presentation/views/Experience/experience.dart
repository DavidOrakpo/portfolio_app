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
                ExperienceTile(
                  company: Companies.Heckerbella,
                  onTap: () {
                    showExperienceDetails(
                        context, Companies.Heckerbella, size.height * 0.65);
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                ExperienceTile(
                  company: Companies.TechiesInfoSystem,
                  onTap: () {
                    showExperienceDetails(context, Companies.TechiesInfoSystem,
                        size.height * 0.65);
                  },
                  imagePath: "assets/images/techies.png",
                ),
                const SizedBox(
                  height: 24,
                ),
                ExperienceTile(
                  company: Companies.Andela,
                  onTap: () {
                    showExperienceDetails(
                        context, Companies.Andela, size.height * 0.65);
                  },
                  imagePath: "assets/images/ANDELA.jpg",
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showExperienceDetails(
      BuildContext context, Companies companies, double bottomSheetHeight) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(24),
      )),
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
            borderRadius: BorderRadius.circular(24),
          ),
          child: SizedBox(
            height: bottomSheetHeight,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              companies.name,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                            ),
                            Container(
                              height: 3,
                              width: 80,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            )
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.cancel_rounded,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.location_city_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        "Address",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 24,
                        ),
                      ),
                      subtitle: Text(
                        companies.address!,
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.6),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.work_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        "Job Position",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 24,
                        ),
                      ),
                      subtitle: Text(
                        companies.jobPosition!,
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.6),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Text(
                      "Duties",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      constraints: const BoxConstraints(
                        minHeight: 80,
                        maxHeight: 200,
                      ),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: companies.listOfDuties.length,
                        itemBuilder: (context, index) {
                          var item = companies.listOfDuties[index];
                          return ListTile(
                            leading: Text(
                              "*",
                              style: TextStyle(
                                fontSize: 30,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            title: Text(
                              item,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
