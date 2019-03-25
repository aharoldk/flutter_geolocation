import 'package:flutter/material.dart';

class ListViewWidget extends StatelessWidget {
  List data;

  ListViewWidget(this.data);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, position) {
            return Card(
              child: Column(children: <Widget>[
                Text(data[position]['infoWindow']['title']),
                Text(data[position]['infoWindow']['snippet']),
                Text("Position : "),
                Text("Latitude : ${data[position]['position']['latitude']}"),
                Text("Longitude : ${data[position]['position']['longitude']}"),
              ],)
            );
          }
      ),
    );
  }
}
