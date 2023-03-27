
import 'package:flutter/material.dart';

class DrawerMenuWidget extends StatelessWidget {
  final VoidCallback onClicked;
  const DrawerMenuWidget(this.onClicked, {super.key});
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onClicked, icon: const Icon(Icons.menu,color: Colors.black,size: 25,));
  }
}
