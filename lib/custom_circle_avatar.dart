import 'package:flutter/material.dart';

class CircleAvatar extends StatelessWidget {
  double size;
  String uriImage;

  CircleAvatar(this.size, this.uriImage);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: new NetworkImage(uriImage))));
  }
}
