import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerMenuWidget extends StatelessWidget {
  final VoidCallback onClicked;
  DrawerMenuWidget(this.onClicked);
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onClicked, icon: Icon(Icons.menu,color: Colors.white,));
  }
}
