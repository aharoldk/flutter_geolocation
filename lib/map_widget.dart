
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatelessWidget {
  List resultData;

  MapWidget(this.resultData);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        onMapCreated: (GoogleMapController controller) {},
//        rotateGesturesEnabled: false,
//        scrollGesturesEnabled: false,
//        tiltGesturesEnabled: false,
        initialCameraPosition:
        CameraPosition(target: LatLng(0, 0), zoom: 16.00),
        markers: _mappingData(),
      ),
    );
  }

  Set<Marker> _mappingData() {
    Set<Marker> _markers = {};

    for (Map a in resultData) {
      LatLng _positionLatLng = LatLng(a['position']['latitude'], a['position']['longitude']);

      _markers.add(Marker(
        markerId: MarkerId(a['markerId'].toString()),
        position: _positionLatLng,
        infoWindow: InfoWindow(
          title: a['infoWindow']['title'],
          snippet: a['infoWindow']['snippet'],
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    }

    return _markers;
  }
}
