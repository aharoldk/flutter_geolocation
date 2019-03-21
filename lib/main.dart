import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  void _startService() async {
    await MethodChannel('com.piknik.asyik/enable_geolocation').invokeMethod("startService");
  }

  void _stopService() async {
    await MethodChannel('com.piknik.asyik/enable_geolocation').invokeMethod("stopService");
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
              children: <Widget>[
                RaisedButton(
                  onPressed: _startService,
                  child: new Text("Start"),
                ),
                RaisedButton(
                  onPressed: _stopService,
                  child: new Text("Stop"),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                onMapCreated: (GoogleMapController controller) {},
                rotateGesturesEnabled: false,
                scrollGesturesEnabled: false,
                tiltGesturesEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: LatLng(37.4219999, -122.0862462),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
