import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Components/DrawerItem.dart';
import '../Components/DrawerItems.dart';
import '../Components/DrawerWidget.dart';
import '../Home/HomePage.dart';

class HomeCon extends StatefulWidget {
  const HomeCon({Key? key}) : super(key: key);

  @override
  State<HomeCon> createState() => _HomeConState();
}

class _HomeConState extends State<HomeCon> {
  late double xOffset;
  late double yOffset;
  late double scaleFactor;
  late bool isDrawerOpen;
  bool isDragging=false;
  DrawerItem item=DrawerItems.home;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openDrawer();
  }
  void openDrawer(){
    return setState(() {
      xOffset=230;
      yOffset=150;
      scaleFactor=0.6;
      bool isDragging=false;
      isDrawerOpen=true;

    });
  }
  void closeDrawer(){
    return setState(() {
      xOffset=0;
      yOffset=0;
      scaleFactor=1;
      isDrawerOpen=false;
    });
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            buildDrawer(),
            buildPage()
          ],
        ),

    );
  }
  Widget buildDrawer(){
    return SafeArea(child: Container(
      width: xOffset,
      child: DrawerWidget(onSelectedItem: (DrawerItem value) {

        setState(() {
          this.item=value;
          closeDrawer();


        });
      },),
    ));
  }
  Widget buildPage(){
    return WillPopScope(
      onWillPop: () async {
        if(isDrawerOpen){
          closeDrawer();
          return false;
        }
        else{
          return true;
        }
      },
      child: GestureDetector(
        onTap: closeDrawer,
        onHorizontalDragStart: (details) => isDragging=true,
        onHorizontalDragUpdate: (details) {
          if(!isDragging) return;
          const delta=1;
          if(details.delta.dx> delta){
            openDrawer();
          }
          else if(details.delta.dx < -delta){
            closeDrawer();
          }
          isDragging = false;
        },
        child: AnimatedContainer(
            transform: Matrix4.translationValues(230, 150, 0)..scale(0.6),
            duration: Duration(milliseconds: 250),
            child: AbsorbPointer(absorbing: isDrawerOpen,child: ClipRRect(
              borderRadius:BorderRadius.circular(isDrawerOpen? 20 : 0) ,
              child: Container(
                  color: isDrawerOpen? Colors.white: Colors.blue,child: getDrawerPage()),
            ))),
      ),
    );
  }
  Widget getDrawerPage(){
    switch (item){
      case DrawerItems.explore:
        return HomePage( openDrawer);
      case DrawerItems.favourites:
        return HomePage( openDrawer);
      case DrawerItems.messages:
        return HomePage( openDrawer);
      case DrawerItems.profile:
        return HomePage( openDrawer);
      case DrawerItems.settings:
        return HomePage( openDrawer);
      case DrawerItems.home:
        return HomePage( openDrawer);

    }
    return HomePage(openDrawer);
  }
}
