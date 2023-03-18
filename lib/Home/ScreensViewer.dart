import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voyage/Components/NavBar.dart';

import '../Components/DrawerMenuWidget.dart';


class ScreenViewer extends StatefulWidget {
  final VoidCallback openDrawer;
  const ScreenViewer(this.openDrawer, {super.key});
  @override
  State<ScreenViewer> createState() => _ScreenViewerState();
}

class _ScreenViewerState extends State<ScreenViewer> {
  Widget activeScreen=Container();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search),color: Colors.white,)
        ],
        backgroundColor: Color.fromRGBO(126, 157, 164, 60),
        leading: DrawerMenuWidget( widget.openDrawer),
      ),
      bottomNavigationBar: NavBar(activeScreen),
    );
  }
}
