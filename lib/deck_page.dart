import 'dart:math';
import 'package:flutter/material.dart';

class DeckPage extends StatefulWidget {
  DeckPage({Key key}) : super(key: key);

  @override
  _DeckPageState createState() => _DeckPageState();
}

class _DeckPageState extends State<DeckPage> {
  @override
  Widget build(BuildContext context) {
    final randomizer = Random();
    const NUMBER_OF_CARDS = 68;
    var index = randomizer.nextInt(NUMBER_OF_CARDS);
    var heading = randomizer.nextBool();
    var image = Image(image: AssetImage('assets/deck/$index.png'));
    return Scaffold(
      body: Center(
          child: Card(
              child: InkWell(
                  onTap: () {
                    setState(() {/* Force refresh */});
                  },
                  child: heading
                      ? image
                      : RotatedBox(quarterTurns: 2, child: image)))),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.home),
          onPressed: () => {Navigator.pushNamed(context, "/")}),
    );
  }
}
