import 'dart:math';
import 'package:flutter/material.dart';

class DeckPage extends StatefulWidget {
  DeckPage({Key key}) : super(key: key);

  @override
  _DeckPageState createState() => _DeckPageState();
}

class _DeckPageState extends State<DeckPage> {
  static const NUMBER_OF_CARDS = 68;
  final _randomizer = Random();
  final _deck = List(NUMBER_OF_CARDS);
  var _index = 0;

  Widget _getNextImage() {
    var heading = _randomizer.nextBool();
    var image = Image(image: AssetImage('assets/deck/${_deck[_index++]}.png'));
    if (heading) return image;
    return RotatedBox(quarterTurns: 2, child: image);
  }

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < _deck.length; ++i) {
      _deck[i] = i;
    }
    _deck.shuffle();

    var child = Card(
        child: InkWell(
            onTap: () {
              setState(() {/* Force refresh */});
            },
            child: _getNextImage()));
    return Scaffold(
      body: Center(child: Draggable(feedback: child, child: child)),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.home),
          onPressed: () => {Navigator.pushNamed(context, "/")}),
    );
  }
}
