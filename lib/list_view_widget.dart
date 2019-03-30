import 'package:flutter/material.dart';
import 'package:piknik_background_geolocation/row_user_nearby.dart';

class ListViewWidget extends StatelessWidget {
  List data;

  ListViewWidget(this.data);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, position) {
          return RowUserNearby(data[position]);
        }
    );
  }
}
