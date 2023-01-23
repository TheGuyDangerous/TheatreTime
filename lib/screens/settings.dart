import 'package:TheatreTime/provider/adultmode_provider.dart';
import 'package:TheatreTime/provider/darktheme_provider.dart';
import 'package:TheatreTime/provider/default_home_provider.dart';
import 'package:TheatreTime/provider/imagequality_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String initialDropdownValue = 'w500';
  int initialHomeScreenValue = 0;
  @override
  Widget build(BuildContext context) {
    final adultChange = Provider.of<AdultmodeProvider>(context);
    final themeChange = Provider.of<DarkthemeProvider>(context);
    final imagequalityChange = Provider.of<ImagequalityProvider>(context);
    final isDark = Provider.of<DarkthemeProvider>(context).darktheme;
    final defaultHomeValue = Provider.of<DeafultHomeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Container(
        color: isDark ? const Color(0xFF202124) : const Color(0xFFF7F7F7),
        child: Column(
          children: [
            SwitchListTile(
              activeColor: const Color(0xFFF57C00),
              value: adultChange.isAdult,
              secondary: const Icon(
                Icons.explicit,
                color: Color(0xFFF57C00),
              ),
              title: const Text('Include Adult'),
              onChanged: (bool value) {
                setState(() {
                  adultChange.isAdult = value;
                });
              },
            ),
            SwitchListTile(
              activeColor: const Color(0xFFF57C00),
              value: themeChange.darktheme,
              secondary: const Icon(
                Icons.dark_mode,
                color: Color(0xFFF57C00),
              ),
              title: const Text('Dark mode'),
              onChanged: (bool value) {
                setState(() {
                  themeChange.darktheme = value;
                });
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.image,
                color: Color(0xFFF57C00),
              ),
              title: const Text('Image quality'),
              trailing: DropdownButton(
                  value: imagequalityChange.imageQuality,
                  items: const [
                    DropdownMenuItem(value: 'original/', child: Text('High')),
                    DropdownMenuItem(
                      value: 'w600_and_h900_bestv2/',
                      child: Text('Medium'),
                    ),
                    DropdownMenuItem(
                      value: 'w500/',
                      child: Text('Low'),
                    )
                  ],
                  onChanged: (String? value) {
                    setState(() {
                      imagequalityChange.imageQuality = value!;
                    });
                  }),
            ),
            ListTile(
              leading: const Icon(
                Icons.phone_android_sharp,
                color: Color(0xFFF57C00),
              ),
              title: const Text('Default home screen'),
              trailing: DropdownButton(
                  value: defaultHomeValue.defaultValue,
                  items: const [
                    DropdownMenuItem(value: 0, child: Text('Movies')),
                    DropdownMenuItem(
                      value: 1,
                      child: Text('TV shows'),
                    ),
                    DropdownMenuItem(value: 2, child: Text('News')),
                    DropdownMenuItem(
                      value: 3,
                      child: Text('Discover'),
                    )
                  ],
                  onChanged: (int? value) {
                    setState(() {
                      defaultHomeValue.defaultValue = value!;
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
