import 'package:flutter/material.dart';
import 'package:portfolio_app/core/enums/enum.dart';

class ExperienceTile extends StatelessWidget {
  ExperienceTile({
    Key? key,
    // this.date,
    required this.company,
    this.backgroudColor,
  })  : date = company!.date,
        title = company.jobPosition,
        super(key: key);
  final String? title, date;

  final Color? backgroudColor;
  final Companies? company;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showExperienceDetails(
            context, company!, MediaQuery.of(context).size.height * 0.75);
      },
      child: Container(
        height: 246,
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.onTertiary,
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
                  company!.imagePath!,
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
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.primaryContainer),
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
                    ListTile(
                      leading: Icon(
                        Icons.calendar_month,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        "Duration",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 24,
                        ),
                      ),
                      subtitle: Text(
                        companies.date!,
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
                    ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: companies.listOfDuties.length,
                      shrinkWrap: true,
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
