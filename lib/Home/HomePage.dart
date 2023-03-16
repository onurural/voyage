import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Components/DrawerMenuWidget.dart';

class HomePage extends StatelessWidget {
  final VoidCallback openDrawer;


  HomePage(this.openDrawer);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: DrawerMenuWidget( openDrawer),
        title: Text("Home Page"),
      ),
    );
  }
}
