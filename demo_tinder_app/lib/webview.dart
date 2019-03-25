import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/rendering.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:fit_image/fit_image.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

/// WEBVIEW PAGE
///
class WebViewPageState extends State<WebViewPage>{

  final String _information;
  final String _URL;

  WebViewPageState(this._information, this._URL);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new MaterialApp(
        routes: {
          "/": (_) => new WebviewScaffold(
            appBar: new AppBar(
              title: new Text(_information),
              centerTitle: true,
              backgroundColor: Color.fromARGB(255, 74, 104, 153),
              leading: IconButton(icon: Icon(Icons.arrow_back),
                onPressed: ()=> goHomeScreen(),
              ),
            ),
            url: _URL,
            withJavascript: true,
          ),
        },
      ),
    );
  }

  void goHomeScreen(){
    Navigator.pop(context);
  }
}

class WebViewPage extends StatefulWidget{

  final String _information;
  final String _URL;

  WebViewPage(this._information, this._URL);

  WebViewPageState createState() => new WebViewPageState(_information, _URL);
}