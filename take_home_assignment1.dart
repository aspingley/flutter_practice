import 'dart:math';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}

class Theme with ChangeNotifier {
  static bool _isDark = false;

  ThemeMode currentTheme() {
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}

Theme currentTheme = Theme();

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      print('Changes');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Startup Name Generator',
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      themeMode: currentTheme.currentTheme(),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>(); // NEW
  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      /*floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          currentTheme.switchTheme();
        },
        label: Text('Theme'),
        icon: Icon(Icons.brightness_5),
      ),*/
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                if (_saved.length == 4) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        //builder: (context) =>
                        //    GridScreen(dataPreviousScreen: _saved)),
                        builder: (context) =>
                            StatelessGridScreen(data: _saved)),
                  );
                } else {
                  return showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text("Warning"),
                      content: Text("You must select exactly 4 favorites"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Text("okay"),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Icon(Icons.arrow_forward),
            ),
            FloatingActionButton(
              onPressed: () {
                currentTheme.switchTheme();
              },
              child: Icon(Icons.brightness_5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return Divider();
          }
          final int index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}

class StatelessGridScreen extends StatelessWidget {
  final Set<WordPair> data;

  StatelessGridScreen({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          title: Center(
            child: Text(
              'Flutter GridView',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        body: Column(children: <Widget>[
          Row(
            //ROW 1
            children: [
              FlippingCell(
                index: 1,
                data: data.elementAt(0).asPascalCase,
              ),

              FlippingCell(
                index: 2,
                data: data.elementAt(1).asPascalCase,
              )
              //getContainer(0),
              //getContainer(1),
            ],
          ),
          Row(//ROW 2
              children: [
            //getContainer(2),
            //getContainer(3),
            FlippingCell(
              index: 3,
              data: data.elementAt(2).asPascalCase,
            ),

            FlippingCell(
              index: 4,
              data: data.elementAt(3).asPascalCase,
            )
          ]),
        ]),
      ),
    );
  }
}

class FlippingCell extends StatefulWidget {
  final int index;
  final String data;
  const FlippingCell({Key key, this.index, this.data}) : super(key: key);
  @override
  _FlippingCellState createState() => _FlippingCellState();
}

class _FlippingCellState extends State<FlippingCell> {
  static bool _showFrontSide = true;

  @override
  Widget build(BuildContext context) {
    return getContainer(widget.index);
  }

  Widget getContainer(int index) {
    return GestureDetector(
      onTap: () => setState(() => _showFrontSide = !_showFrontSide),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        width: MediaQuery.of(context).size.width * 0.40,
        //color: Colors.blue,
        margin: EdgeInsets.all(25.0),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 600),
          transitionBuilder: __transitionBuilder,
          child:
              _showFrontSide ? _buildFront(index + 1) : _buildRear(widget.data),
        ),
      ),
    );
  }

  Widget _buildFront(int index) {
    return __buildLayoutFront(
      key: ValueKey(true),
      backgroundColor: Colors.blue,
      count: index,
    );
  }

  Widget _buildRear(String name) {
    return __buildLayoutRear(
      key: ValueKey(false),
      backgroundColor: Colors.blue.shade700,
      faceName: name,
    );
  }

  Widget __buildLayoutFront({Key key, int count, Color backgroundColor}) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://picsum.photos/250?image=' + count.toString()),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      //child: Center(
      //  child: Text(faceName.substring(0, 1), style: TextStyle(fontSize: 80.0)),
      //),
    );
  }

  Widget __buildLayoutRear({Key key, String faceName, Color backgroundColor}) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
        color: backgroundColor,
      ),
      child: Center(
        child: Text(faceName, style: TextStyle(fontSize: 25.0)),
      ),
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget.key);
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: Matrix4.rotationY(value),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }
}
