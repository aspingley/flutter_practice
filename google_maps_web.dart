//Step 0: Create API key using Google Cloud platform 
//1. Go to https://console.cloud.google.com/project/_/apiui/credential 
//2. Click "Select a project" from top bar and create a new project with a meaningful name. 
//3. On the newly create project page, select "Credentials" option from left pane.  
//4. Below the top bar, you will see "+ CREATE CREDENTIALS" option. Click and select API key. The API key created dialog displays your newly created API key. 
//5. Click Close. The new API key is listed on the Credentials page under API keys. 

//Step 1: Create Flutter app 
//1. Create a flutter app with boilerplate code using Visual Studio Code 
//2. Open pubspec.yaml file. Add "google_maps:" to dependencies section under "cupertino_icons: ^1.0.1". 
//3. Open index.html and add the following statement inside the body section: 
//4. <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_GOOGLE_CREDENTIALS_API_KEY"></script> 

import 'package:flutter/material.dart';
import 'package:google_maps/google_maps.dart';
import 'dart:ui' as ui;
import 'dart:html';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return getMap();
  }
}

Widget getMap() {
  String htmlId = "27";

  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
    final myLatlng = LatLng(45.51999139651352, -120.79857460430122);

    final mapOptions = MapOptions()
      ..zoom = 10
      ..center = LatLng(45.51999139651352, -120.79857460430122);

    final elem = DivElement()
      ..id = htmlId
      ..style.width = "100%"
      ..style.height = "100%"
      ..style.border = 'none';

    final map = GMap(elem, mapOptions);

    Marker(MarkerOptions()
      ..position = myLatlng
      ..map = map
      ..title = 'Hello World!');

    return elem;
  });

  return HtmlElementView(viewType: htmlId);
}
