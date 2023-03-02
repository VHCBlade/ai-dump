import 'dart:io';

import 'package:ai_dump/saved_themes.dart';
import 'package:ai_dump/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MyHomePage(title: "Theme Producer");
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final loadedThemes = <LoadedThemeData>[];
  final savedThemes = <LoadedThemeData>[];

  LoadedThemeData? get loadedTheme =>
      loadedThemes.isEmpty ? null : loadedThemes.first;
  ThemeData? get theme => loadedTheme?.theme;

  final filename = "saved_themes.dart";

  void save() async {
    if (loadedTheme == null) {
      return;
    }

    savedThemes.add(loadedTheme!);
    loadedThemes.removeAt(0);
    final file = File(filename);
    // print(file.absolute.path);
    await file.writeAsString(
        "final themes = [\n${savedThemes.map((e) => "VHCBladeTheme("
            "name: '${e.name}',"
            "brightness: ${e.brightness},"
            "primaryColor: const Color(${e.primaryColor.value}),"
            "secondaryColor: const Color(${e.secondaryColor.value}),"
            "cardColor: const Color(${e.cardColor.value}),"
            "highlightColor: const Color(${e.highlightColor.value}),"
            "backgroundColor: Color(${e.backgroundColor.value})),").join("\n")}\n];");

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadThemes();
  }

  void loadThemes() async {
    // This is for loading from the ai dump
    // final themes = await rootBundle.loadString("dump/themes.csv");
    // for (final row in themes.split("\n").skip(1)) {
    //   final splitRow = row.split(",");
    //   if (splitRow.length < 3) {
    //     continue;
    //   }
    //   loadedThemes.add(LoadedThemeData(
    //       name: splitRow[0],
    //       primaryColor: Color(
    //           int.parse(splitRow[1].substring(1), radix: 16) + 0xFF000000),
    //       secondaryColor: Color(
    //           int.parse(splitRow[2].substring(1), radix: 16) + 0xFF000000)));
    // }

    // This is for loading from the already created themes
    for (final theme in themes) {
      loadedThemes.add(LoadedThemeData(
          name: theme.name,
          primaryColor: theme.primaryColor,
          secondaryColor: theme.secondaryColor)
        ..backgroundColor = theme.backgroundColor
        ..brightness = theme.brightness
        ..cardColor = theme.cardColor
        ..highlightColor = theme.highlightColor);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: Scaffold(
        appBar: AppBar(
          title: Text(loadedTheme?.name ?? widget.title),
        ),
        body: loadedTheme == null
            ? Center(child: Container())
            : ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: OutlinedButton(
                          onPressed: () {},
                          child: const Text("Set Primary Color")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () {},
                          child: const Text("Set Secondary Color")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListTile(
                          onTap: () => setState(() => loadedTheme!.brightness =
                              theme!.brightness == Brightness.dark
                                  ? Brightness.light
                                  : Brightness.dark),
                          title: const Text("Toggle Brightness")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                          onPressed: () => setState(() {
                                loadedTheme!.backgroundColor = Colors.white;
                                loadedTheme!.recalcCardColor();
                              }),
                          child: const Text("Set Background Color to white")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                          onPressed: () => setState(() {
                                loadedTheme!.backgroundColor =
                                    const Color.fromARGB(255, 35, 35, 35);
                                loadedTheme!.recalcCardColor();
                              }),
                          child: const Text("Set Background Color to gray")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                          onPressed: () => setState(() {
                                loadedTheme!.backgroundColor =
                                    loadedTheme!.secondaryColor;
                                loadedTheme!.recalcCardColor();
                              }),
                          child: const Text(
                              "Set Background Color to secondary color")),
                    ),
                    Card(
                        child: Column(
                      children: [
                        const Text("This is the example of a card!"),
                        const Text("Hooray!"),
                        ElevatedButton(
                            onPressed: save, child: const Text("Save Theme")),
                      ],
                    ))
                  ]),
      ),
    );
  }
}
