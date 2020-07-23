import 'package:flutter/material.dart';

import 'deck_page.dart';
import 'dice_page.dart';
import 'names_page.dart';

// This is both the home page and the dice-rolling page.

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

enum Page {
  Dice,
  Deck,
  AmberDwellers,
  ShadowDwellers,
  ChaosDwellers,
}

class _HomePageState extends State<HomePage> {
  Page _page;
  int _index;

  @override
  void initState() {
    super.initState();
    _page = Page.Deck;
    _index = 0;
  }

  Widget _getPage() {
    switch (_page) {
      case Page.AmberDwellers:
        return NamesPage(
          namePaths: [
            NamePath(
              firstNames: "assets/names/british-first-names.txt",
              surnames: "assets/names/noble-surnames.txt",
              hints: "assets/names/emoji.txt",
            )
          ],
        );
      case Page.ShadowDwellers:
        return NamesPage(
          namePaths: [
            NamePath(
              firstNames: "assets/names/chinese-first-names.txt",
              surnames: "assets/names/chinese-surnames.txt",
              hints: "assets/names/emoji.txt",
            ),
            NamePath(
              firstNames: "assets/names/czech-first-names.txt",
              surnames: "assets/names/czech-surnames.txt",
              hints: "assets/names/emoji.txt",
            )
          ],
        );
      case Page.ChaosDwellers:
        return NamesPage(
          namePaths: [
            NamePath(
              firstNames: "assets/names/ndebele-first-names.txt",
              surnames: "assets/names/ndebele-surnames.txt",
              hints: "assets/names/emoji.txt",
            )
          ],
        );
      case Page.Deck:
        return DeckPage();
      case Page.Dice:
        return DicePage();
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _getPage(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index ?? 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.toys), title: Text("Dice")),
          BottomNavigationBarItem(
              icon: Icon(Icons.tap_and_play), title: Text("Deck")),
          BottomNavigationBarItem(icon: Icon(Icons.face), title: Text("Chaos")),
          BottomNavigationBarItem(
              icon: Icon(Icons.money_off), title: Text("Shadows")),
          BottomNavigationBarItem(
              icon: Icon(Icons.euro_symbol), title: Text("Amberites")),
        ],
        onTap: (index) {
          _index = index;
          switch (index) {
            case 0:
              _page = Page.Dice;
              break;
            case 1:
              _page = Page.Deck;
              break;
            case 2:
              _page = Page.ChaosDwellers;
              break;
            case 3:
              _page = Page.ShadowDwellers;
              break;
            case 4:
              _page = Page.AmberDwellers;
              break;
          }
          setState(() {});
        },
      ),
    );
  }
}
