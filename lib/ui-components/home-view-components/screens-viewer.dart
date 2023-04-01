

import 'package:flutter/material.dart';
import 'package:voyage/ui-components/drawer-app-bar.dart';

import 'package:voyage/views/home-view/home.view.dart';




class ScreenViewer extends StatefulWidget {
  final VoidCallback openDrawer;
  final int index;

  const ScreenViewer(this.openDrawer, this.index, {super.key});

  @override
  State<ScreenViewer> createState() => _ScreenViewerState();
}

class _ScreenViewerState extends State<ScreenViewer> {
  Widget activeScreen=Container();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activeScreen=const HomePage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:DrawerAppBar(widget.openDrawer),

      body: activeScreen,
    );
  }
}
