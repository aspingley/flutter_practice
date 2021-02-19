import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    //title: 'Navigation Basics',
    //home: FirstRoute(),
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => FirstRoute(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/second': (context) => SecondRoute(),
      '/third': (context) => ThirdRoute(),
    },
  ));
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            ElevatedButton(
              child: Text('Open second route'),
              onPressed: () {
                Navigator.pushNamed(context, '/second');
                /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondRoute()),
            );*/
              },
            ),
            Padding(padding: const EdgeInsets.all(20.0)),
            ElevatedButton(
              child: Text('Open third route'),
              onPressed: () {
                Navigator.pushNamed(context, '/third');
                /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondRoute()),
            );*/
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FirstRoute()),
            );*/
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

class ThirdRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Third Route"),
        ),
        body: Center(
          child: Column(children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FirstRoute()),
            );*/
              },
              child: Text('Go back!'),
            ),
          ]),
        ));
  }
}
