import 'dart:math';
import 'package:flutter/material.dart';

class NamePath {
  NamePath(
      {@required this.firstNames,
      @required this.surnames,
      @required this.hints});
  final String firstNames;
  final String surnames;
  final String hints;
}

class NameFamily {
  NameFamily({@required firstNames, @required surnames, @required hints})
      : this.firstNames = firstNames,
        this.surnames = surnames,
        this.hints = hints;
  final List<String> firstNames;
  final List<String> surnames;
  final List<String> hints;
}

class NamesPage extends StatefulWidget {
  NamesPage({Key key, @required this.namePaths}) : super(key: key);

  final List<NamePath> namePaths;

  @override
  _NamesPageState createState() => _NamesPageState();
}

class _NamesPageState extends State<NamesPage> {
  final _randomizer = Random();
  Future<List<NameFamily>> _init;

  Future<NameFamily> _getFamily(NamePath namePath) {
    var firstNames = DefaultAssetBundle.of(context)
        .loadString(namePath.firstNames)
        .then((value) => value.split("\n"));
    var surnames = DefaultAssetBundle.of(context)
        .loadString(namePath.surnames)
        .then((value) => value.split("\n"));
    var hints = DefaultAssetBundle.of(context)
        .loadString(namePath.hints)
        .then((value) => value.split("\n"));

    Future<List<List<String>>> wait =
        Future.wait([firstNames, surnames, hints]);
    var family = wait.then((value) {
      var firstNames = value[0];
      var surnames = value[1];
      var hints = value[2];
      return NameFamily(
          firstNames: firstNames, surnames: surnames, hints: hints);
    });
    return family;
  }

  @override
  initState() {
    super.initState();
    var future = Future.wait(
        widget.namePaths.map((namePath) => _getFamily(namePath)).toList());
    _init = future;
  }

  String _nextName(AsyncSnapshot<List<NameFamily>> snapshot) {
    var family = snapshot.data[_randomizer.nextInt(snapshot.data.length)];
    var firstNames = family.firstNames;
    var surnames = family.surnames;
    var hints = family.hints;
    var firstName = firstNames[_randomizer.nextInt(firstNames.length)];
    var surname = surnames[_randomizer.nextInt(surnames.length)];
    var hint = hints[_randomizer.nextInt(hints.length)];
    return "$firstName $surname $hint";
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
                  AsyncSnapshot<List<NameFamily>> snapshot) {
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
