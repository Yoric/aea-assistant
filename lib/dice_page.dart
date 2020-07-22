import 'dart:math';
import 'package:flutter/material.dart';

// This is both the home page and the dice-rolling page.

class DicePage extends StatefulWidget {
  DicePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  Random _randomizer = Random();
  double _sliderPosition = 2.0;
  final List<int> _values = [];

  @override
  void initState() {
    super.initState();
    _randomize();
  }

  void _randomize() {
    setState(() {
      for (var i = 0; i < _values.length; ++i) {
        _values[i] = _randomizer.nextInt(6) + 1;
      }
      _values.sort();
    });
  }

  void _updateNumberOfDice(double sliderPosition) {
    _sliderPosition = sliderPosition;
    _values.length = sliderPosition.floor();
    _randomize();
  }

  String _getDieLabel(value) {
    switch (value) {
      case 1:
        return "⚀";
      case 2:
        return "⚁";
      case 3:
        return "⚂";
      case 4:
        return "⚃";
      case 5:
        return "⚄";
      case 6:
        return "⚅";
    }
    return '$value';
  }

  TextStyle _getDieStyle(value) {
    const FONT_SIZE = 100.0;
    var base = TextStyle(fontSize: FONT_SIZE, fontWeight: FontWeight.bold);
    if (value <= 3) return base.copyWith(color: Color.fromARGB(255, 255, 0, 0));
    if (value <= 5) return base.copyWith(color: Color.fromARGB(255, 0, 0, 0));
    return base.copyWith(color: Color.fromARGB(255, 0, 120, 0));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the DicePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: _values == null
                      ? [TextSpan(text: "Roll dice")]
                      : _values
                          .map((e) => TextSpan(
                                text: _getDieLabel(e),
                                style: _getDieStyle(e),
                              ))
                          .toList(),
                )),
            Slider(
              value: max(_sliderPosition, 1.0),
              onChanged: _updateNumberOfDice,
              onChangeStart: (value) {
                _randomize();
              },
              onChangeEnd: (value) {
                _randomize();
              },
              label: _values == null ? null : '${_values.length}',
              min: 1.0,
              max: 10.0,
              divisions: 10,
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.tap_and_play), title: Text("Deck")),
          BottomNavigationBarItem(
              icon: Icon(Icons.money_off), title: Text("Amberite")),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, "/deck");
              break;
            case 1:
              Navigator.pushNamed(context, "/amberites");
              break;
          }
        },
      ),
    );
  }
}
