import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Button App",
        debugShowCheckedModeBanner: false,
        home: ButtonApp() 
    );
  }
}


class ButtonApp extends StatefulWidget {
  @override
  _button createState() => new _button();
}

class _button extends State<ButtonApp> {
  String _text = '';

  void buttonMethod(value) {
    setState(() {
      _text = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(

        title: new Text("Button App"),
        centerTitle: true,
      ),
      body: new Padding(
        padding: const EdgeInsets.all(50.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[

            new Padding(padding: const EdgeInsets.all(20.0)),

            new RaisedButton(
                onPressed: () {
                  buttonMethod('Raised Button was Pressed');
                },
                child: new Text('Raised Button', style: (TextStyle(fontSize: 24,)),),

            ),

            new Padding(padding: const EdgeInsets.all(15.0)),

            new FlatButton(
                onPressed: () {
                  buttonMethod('Flat Button was Pressed');
                },
                child: new Text('Flat Button', style: (TextStyle(fontSize: 24,)),),

            ),

            new Padding(padding: const EdgeInsets.all(10.0)),

            new IconButton(
                icon: new Icon(Icons.android_sharp, size: 24,),
                onPressed: (){
                  buttonMethod('Icon Button was Pressed');
            }
            ),

            new Padding(padding: const EdgeInsets.all(10.0)),

            new Text(_text,style: (TextStyle(fontSize: 24, color: Colors.teal)),),

            new Expanded(
                child: new Align(
                    alignment: Alignment.bottomLeft,
                    child: new Container(
                      margin: EdgeInsets.only(left: 16, bottom: 16),
                      child: new FloatingActionButton(
                          onPressed: () {
                            buttonMethod("FloatingActionButton was Pressed");
                          },
                          child: Icon(Icons.add_comment),
                          backgroundColor: Colors.deepPurple),
                    ))),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            buttonMethod("Extended FloatingActionButton was Pressed");
          },
          label: new Text("Approve"),
          icon: Icon(Icons.thumb_up),
          backgroundColor: Colors.deepOrange),
    );
  }
}
