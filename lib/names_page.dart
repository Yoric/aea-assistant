import 'dart:math';
import 'package:flutter/material.dart';

class NamesPage extends StatefulWidget {
  NamesPage({Key key}) : super(key: key);

  @override
  _NamesPageState createState() => _NamesPageState();
}

class _NamesPageState extends State<NamesPage> {
  final _randomizer = Random();
  Future<List<List<String>>> _init;

  @override
  initState() {
    super.initState();
    var firstNames = DefaultAssetBundle.of(context)
        .loadString("assets/names/british-first-names.txt")
        .then((value) => value.split("\n"));
    var lastNames = DefaultAssetBundle.of(context)
        .loadString("assets/names/noble-surnames.txt")
        .then((value) => value.split("\n"));
    _init = firstNames.then((firstNames) {
      return lastNames.then((lastNames) {
        var result = [firstNames, lastNames];
        return result;
      });
    });
  }

  String _nextName(AsyncSnapshot<List<List<String>>> snapshot) {
    var firstNames = snapshot.data[0];
    var surnames = snapshot.data[1];
    var firstName = firstNames[_randomizer.nextInt(firstNames.length)];
    var surname = surnames[_randomizer.nextInt(surnames.length)];
    return "$firstName $surname";
  }

  @override
  Widget build(BuildContext context) {
    var style = TextStyle(
      fontSize: 20.0,
    );
    return Scaffold(
      body: Center(
          child: FutureBuilder(
              future: _init,
              builder: (BuildContext context,
                  AsyncSnapshot<List<List<String>>> snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading...");
                }
                return ListView.builder(
                    addAutomaticKeepAlives: false,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                          child: Text(
                        _nextName(snapshot),
                        style: style,
                      ));
                    });
              })),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.home),
          onPressed: () => {Navigator.pushNamed(context, "/")}),
    );
  }
}
