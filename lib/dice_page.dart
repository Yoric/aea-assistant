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
  double _sliderPosition;
  List<int> _values;

  @override
  void initState() {
    super.initState();
    _values = [0, 0];
    _silentRandomize();
    _sliderPosition = 2.0;
  }

  void _silentRandomize() {
    for (var i = 0; i < _values.length; ++i) {
      _values[i] = _randomizer.nextInt(6) + 1;
    }
    _values.sort();
  }

  void _randomize() {
    setState(() {
      _silentRandomize();
    });
  }

  void _updateNumberOfDice(double sliderPosition) {
    _sliderPosition = sliderPosition;
    _values.length = sliderPosition.floor();
    _randomize();
  }

  String _getDieLabel(value) {
    print("_getDieLabel($value)");
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: _values
                  .map((e) => TextSpan(
                        text: _getDieLabel(e),
                        style: _getDieStyle(e),
                      ))
                  .toList(),
            )),
        Slider(
          value: _sliderPosition,
          onChanged: _updateNumberOfDice,
          onChangeStart: (value) {
            _randomize();
          },
          onChangeEnd: (value) {
            _randomize();
          },
          label: '${_values.length}',
          min: 1.0,
          max: 10.0,
          divisions: 10,
        )
      ],
    );
  }
}
