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
      theme: ThemeData.light(),
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
  bool slider = false;

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

  void _onChangedSlider(bool value) => setState(() => slider = value);


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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            Switch(value: slider, onChanged: _onChangedSlider),
          ],
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(120.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 14.0),
                      child: TextField(
                        decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: new TextStyle(color: Colors.grey[800]),
                          hintText: "Type in your text",
                          fillColor: Colors.white70,
                          prefixIcon: Icon(
                            Icons.location_on,
                            size: 20.0,
                            color: Colors.red,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      )
                    ),
                    TabBar(
                      tabs: [
                        Tab(text: "Map"),
                        Tab(text: "List"),
                      ]
                    )
                  ],
                ),
              ),
            ),
        ),

        body: TabBarView(
          children: [
            Container(
              child: currentPosition != null ? _showUI() : null,
            ),
            Container(
              child: currentPosition != null ? _showUI() : null,
            ),
          ]
        ),
      ),
    );
  }
}
