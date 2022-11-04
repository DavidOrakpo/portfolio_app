import 'package:flutter/material.dart';
import 'package:portfolio_app/core/StateManagement/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                  "SETTINGS",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dark Mode",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Checkbox(
                        value: context.read<DarkThemeProvider>().darkTheme,
                        onChanged: (bool? value) {
                          context.read<DarkThemeProvider>().darkTheme = value!;
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
