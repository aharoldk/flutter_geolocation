import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:piknik_background_geolocation/row_user_nearby.dart';

class MapWidget extends StatefulWidget {
  List resultData;

  MapWidget(this.resultData);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  Map data;

  void setData(mapData) {
    setState(() {
      data = mapData;
    });
  }

  Set<Marker> _mappingData() {
    Set<Marker> _markers = {};

    for (Map data in widget.resultData) {
      LatLng _positionLatLng =
          LatLng(data['position']['latitude'], data['position']['longitude']);

      _markers.add(Marker(
        markerId: MarkerId(data['markerId'].toString()),
        position: _positionLatLng,
        icon: BitmapDescriptor.defaultMarker,
        onTap: () => setData(data),
      ));
    }

    return _markers;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: GoogleMap(
            onMapCreated: (GoogleMapController controller) {},
            rotateGesturesEnabled: false,
            scrollGesturesEnabled: false,
            tiltGesturesEnabled: false,
            initialCameraPosition:
                CameraPosition(target: LatLng(0, 0), zoom: 16.00),
            markers: _mappingData(),
          ),
        ),
        data == null ? Container() : _floatingCard(),
      ],
    );
  }

  Widget _floatingCard() {
    return Positioned(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 60.0),
          child: RowUserNearby(data),
        ),
      ),
    );
  }
}
