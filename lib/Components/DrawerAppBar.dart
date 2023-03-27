import 'package:flutter/material.dart';

import 'DrawerMenuWidget.dart';

class DrawerAppBar extends StatelessWidget with PreferredSizeWidget  {

  final VoidCallback openDrawer;


  DrawerAppBar(this.openDrawer, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: DrawerMenuWidget(openDrawer),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );


  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.infinity, 30);


}
