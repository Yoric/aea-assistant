import 'package:flutter/material.dart';

import 'dice_page.dart';
import 'deck_page.dart';
import 'names_page.dart';

void main() {
  runApp(AeAAssistantApp());
}

class AeAAssistantApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AeA Assistant',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) {
            return DicePage(title: 'AeA assistant');
          },
          '/deck': (BuildContext context) {
            return DeckPage();
          },
          '/amberites': (BuildContext context) {
            return NamesPage(
              namePaths: [
                NamePath(
                  firstNames: "assets/names/british-first-names.txt",
                  surnames: "assets/names/noble-surnames.txt",
                )
              ],
            );
          },
          '/shadow-dwellers': (BuildContext context) {
            return NamesPage(
              namePaths: [
                NamePath(
                  firstNames: "assets/names/chinese-first-names.txt",
                  surnames: "assets/names/chinese-surnames.txt",
                ),
                NamePath(
                  firstNames: "assets/names/czech-first-names.txt",
                  surnames: "assets/names/czech-surnames.txt",
                )
              ],
            );
          },
          '/chaos-dwellers': (BuildContext context) {
            return NamesPage(
              namePaths: [
                NamePath(
                  firstNames: "assets/names/ndebele-first-names.txt",
                  surnames: "assets/names/ndebele-surnames.txt",
                )
              ],
            );
          },
        });
  }
}
