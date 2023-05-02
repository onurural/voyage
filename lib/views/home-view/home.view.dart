import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/ui-components/drawer-items.dart';
import 'package:voyage/ui-components/home-view-components/category-cards-list.dart';
import 'package:voyage/ui-components/home-view-components/search-bar.dart';
import 'package:voyage/ui-components/home-view-components/top-visited-row-list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _containerHeight = 300;
  final double _maxContainerHeight = 600;
  final double _minContainerHeight = 150;

  late double xOffset;
  late double yOffset;
  late double scaleFactor;
  late bool isDrawerOpen;
  bool isDragging = false;
  void openDrawer() {
    return setState(() {
      xOffset = 230;
      yOffset = 150;
      scaleFactor = 0.6;
      isDrawerOpen = true;
    });
  }

  void closeDrawer() {
    return setState(() {
      xOffset = 0;
      yOffset = 0;
      scaleFactor = 1;
      isDrawerOpen = false;
    });
  }

  DrawerItem item = DrawerItems.home;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openDrawer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: const AssetImage(
                ''
                    'assets/Images/ContainerBackgroundImage.jpg',
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.darken)),
        ),
        child: Stack(
          children: [
            NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification) {
                  setState(() {
                    _containerHeight -= scrollNotification.scrollDelta!;
                    _containerHeight = _containerHeight.clamp(
                        _minContainerHeight, _maxContainerHeight);
                  });
                }
                return true;
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                        padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
                        child: SearchBar([])),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                      child: Text(
                        'Explore top destinations around the world',
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      decoration: const BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5))),
                      child: Column(
                        children: const [
                          Padding(
                            padding: EdgeInsets.fromLTRB(110, 0, 110, 0),
                            child: Divider(
                              color: Color.fromRGBO(93, 94, 94, 100),
                              thickness: 5,
                              height: 20,
                              indent: 20,
                              endIndent: 20,
                            ),
                          ),
                          TopVisitedRowList(),
                          CategoryCardsList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedContainer(
              height: _containerHeight,
              duration: const Duration(milliseconds: 300),
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
            ),
          ],
        ),),
    );
  }
}
