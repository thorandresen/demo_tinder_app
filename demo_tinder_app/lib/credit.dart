import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    return Scaffold(
      appBar: new AppBar(
        title: Text('Credits'),
        centerTitle: true,
      ),
      body: new SingleChildScrollView(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Widgets: ',
                  style: TextStyle(
                    fontSize: 7 * (queryData.size.width / 100),
                  ),
                ),
                Text('cupertino_icons'),
                Text('percent_indicator'),
                Text('flip_card'),
                Text('fit_image'),
                Text('webview_flutter'),
                Text('flutter_webview_plugin'),
                Text('cloud_firestore'),
                Text('path_provider'),
                Text('shared_preferences'),
                Text('uuid'),
                Text('pie_chart'),
                Text('fluttertoast'),

                Text(''),
                Text(
                  'Graphics: ',
                  style: TextStyle(
                    fontSize: 7 * (queryData.size.width / 100),
                  ),
                ),
                Text('App logo: freepik.com'),

                Text(''),
                Text(
                  'Special thanks: ',
                  style: TextStyle(
                    fontSize: 7 * (queryData.size.width / 100),
                  ),
                ),
                Text('Everyone at the flutterdev discord for helping out.'),

              ],
            )
          ],
        ),
      ),
    );
  }
}
