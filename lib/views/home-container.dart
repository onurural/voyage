import 'package:flutter/material.dart';
import 'package:voyage/ui-components/drawer-items.dart';
import 'package:voyage/ui-components/drawer.widget.dart';
import 'package:voyage/ui-components/home-view-components/screens-viewer.dart';



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
    closeDrawer();
  }
  void openDrawer(){
    return setState(() {
      xOffset=300;
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
      backgroundColor: const Color.fromRGBO(44, 87, 116, 100),

        body: Stack(
          children: [
            buildDrawer(),
            buildPage(),

          ],
        ),

    );
  }

  Widget buildDrawer() {
    return SafeArea(
      child: Container(
        width: xOffset,

        child: DrawerWidget(onSelectedItem: (DrawerItem value) {
          setState(() {
            item = value;
            closeDrawer();
          });
        }),
      ),
    );
  }

  Widget buildPage() {
    return WillPopScope(
      onWillPop: () async {
        if (isDrawerOpen) {
          closeDrawer();
          return false;
        } else {
          return true;
        }
      },
      child: GestureDetector(
        onTap: closeDrawer,
        onHorizontalDragStart: (details) => isDragging = true,
        onHorizontalDragUpdate: (details) {
          if (!isDragging) return;
          const delta = 1;
          if (details.delta.dx > delta) {
            openDrawer();
          } else if (details.delta.dx < -delta) {
            closeDrawer();
          }
          isDragging = false;
        },
        child: AnimatedContainer(
          transform: Matrix4.translationValues(xOffset, yOffset, 0)
            ..scale(scaleFactor),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(isDrawerOpen ? 20 : 0),
            boxShadow: [
              BoxShadow(
                color: isDrawerOpen ? Colors.black.withOpacity(0.5) : Colors.transparent,
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: AbsorbPointer(
            absorbing: isDrawerOpen,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(isDrawerOpen ? 20 : 0),
              child: Container(
                color: isDrawerOpen ? Colors.white : Colors.blue,
                child: getDrawerPage(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getDrawerPage(){
    return ScreenViewer(openDrawer,item.title);
  }
}
