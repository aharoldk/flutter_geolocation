import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:piknik_background_geolocation/list_view_widget.dart';
import 'package:piknik_background_geolocation/map_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Piknik',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Piknik Background Geolocation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _uiName = "Map";
  Position currentPosition;
  List resultData;

  @override
  void initState() {
    super.initState();

    getInitialData();
  }

  void getInitialData() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    String data = await DefaultAssetBundle.of(context).loadString("assets/data.json");

    setState(() {
      currentPosition = position;
      resultData = json.decode(data);
    });
  }

  void _startService() async {
    await MethodChannel('com.piknik.asyik/enable_geolocation')
        .invokeMethod("startService");
  }

  void _stopService() async {
    await MethodChannel('com.piknik.asyik/enable_geolocation')
        .invokeMethod("stopService");
  }

  void _changeUI(String _uiName) {
    setState(() {
      this._uiName = _uiName;
    });
  }


  Widget _showUI() {
    Widget widget;

    switch (_uiName) {
      case "Map":
        widget = MapWidget(resultData);
        break;
      case "List":
        widget = ListViewWidget(resultData);
        break;
    }

    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  onPressed: _startService,
                  child: new Text("Start"),
                ),
                RaisedButton(
                  onPressed: _stopService,
                  child: new Text("Stop"),
                ),
                RaisedButton(
                  onPressed: () => _changeUI("Map"),
                  child: new Text("Map"),
                ),
                RaisedButton(
                  onPressed: () => _changeUI("List"),
                  child: new Text("List"),
                ),
              ],
            ),
            Container(
              child: currentPosition != null ? _showUI() : null,
            ),
          ],
        ),
      ),
    );
  }
}
