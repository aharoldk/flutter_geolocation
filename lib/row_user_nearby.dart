import 'package:flutter/material.dart';

class RowUserNearby extends StatelessWidget {
  Map data;

  RowUserNearby(this.data);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          child: CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(
                  "https://natureconservancy-h.assetsadobe.com/is/image/content/dam/tnc/nature/en/photos/tnc_36722630_Full.jpg?crop=0,0,6549,4912&wid=580&hei=435&scl=11.291954022988506")),
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("${data['infoWindow']['title']} \n", style: TextStyle(fontSize: 22.0)),
              Text(data['infoWindow']['message'], style: TextStyle(fontSize: 18.0)),
              InkWell(
                child: Text("See Profile", style: TextStyle(fontSize: 18.0)),
              )
            ],
          ),
        )
      ],
    );
  }
}
