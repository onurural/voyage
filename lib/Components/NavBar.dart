import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'GradientIcon.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool homeScreenSelected = false;
  bool scheduleScreenSelected = false;
  bool createScheduleScreenSelected = false;
  bool documentsScreensSelected=false;
  bool profileScreenSelected=false;




  void selectScreen(int index){

    setState(() {


      if(index ==0 ){

        homeScreenSelected=true;
        scheduleScreenSelected=false;
        createScheduleScreenSelected=false;
        documentsScreensSelected=false;
        profileScreenSelected=false;


      }
      else if(index ==1 ){

        homeScreenSelected=false;
        scheduleScreenSelected=true;
        createScheduleScreenSelected=false;
        documentsScreensSelected=false;
        profileScreenSelected=false;
      }
      else if(index == 2){

        homeScreenSelected=false;
        scheduleScreenSelected=false;
        createScheduleScreenSelected=true;
        documentsScreensSelected=false;
        profileScreenSelected=false;
      }
      else if( index ==3){

        homeScreenSelected=false;
        scheduleScreenSelected=false;
        createScheduleScreenSelected=false;
        documentsScreensSelected=true;
        profileScreenSelected=false;
      }
      else if(index ==4){



        homeScreenSelected=false;
        scheduleScreenSelected=false;
        createScheduleScreenSelected=false;
        documentsScreensSelected=false;
        profileScreenSelected=true;
      }

    });
  }


  List<Widget> gradientIcons = [
    GradientIcon(
        icon: Icons.home,
        size: 40,
        gradient: LinearGradient(
            colors: [Color.fromRGBO(37, 154, 180, 100), Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter)),
    GradientIcon(
        icon: Icons.calendar_month,
        size: 40,
        gradient: LinearGradient(
            colors: [Color.fromRGBO(37, 154, 180, 100), Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter)),
    GradientIcon(
        icon: Icons.add_circle_outlined,
        size: 40,
        gradient: LinearGradient(
            colors: [Color.fromRGBO(37, 154, 180, 100), Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter)),
    GradientIcon(
        icon: Icons.document_scanner,
        size: 40,
        gradient: LinearGradient(
            colors: [Color.fromRGBO(37, 154, 180, 100), Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter)),
    GradientIcon(
        icon: Icons.account_circle,
        size: 40,
        gradient: LinearGradient(
            colors: [Color.fromRGBO(37, 154, 180, 100), Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter)),
  ];
  List<Widget> icons = [
    Icon(Icons.home,
        color: Colors.white, size: 40),
    Icon(Icons.calendar_month_rounded,
        color: Colors.white, size: 40),
    Icon(Icons.add_circle_rounded,
        color: Colors.white, size: 40),
    Icon(Icons.document_scanner,
        color:  Colors.white, size: 40),
    Icon(Icons.account_circle,
        color:  Colors.white, size: 40),

  ];




  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 12),


            width: double.infinity,

              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.black
                ),
                color: Color.fromRGBO(126, 157, 164, 60),
                borderRadius: BorderRadius.circular(25)
              ),




              child:Row(
                mainAxisSize: MainAxisSize.max,

      children: [
          Expanded(
            child: Container(
              child: MaterialButton(onPressed: () {
                selectScreen(0);
              },
                child: AnimatedCrossFade(firstChild: icons[0], secondChild: gradientIcons[0], crossFadeState: homeScreenSelected? CrossFadeState.showSecond: CrossFadeState.showFirst, duration: Duration(seconds: 1),

                )

              )
            ),
          ),
          Expanded(
            child: Container(
              child:MaterialButton(onPressed: () { 
                selectScreen(1);
              },
                child: AnimatedCrossFade(firstChild: icons[1], secondChild: gradientIcons[1], crossFadeState: scheduleScreenSelected? CrossFadeState.showSecond: CrossFadeState.showFirst, duration: Duration(seconds: 1)),

              )
            ),
          ),
          Expanded(
            child: Container(
              child: MaterialButton(onPressed: () {
                selectScreen(2);
              },
                child: AnimatedCrossFade(firstChild: icons[2], secondChild: gradientIcons[2], crossFadeState: createScheduleScreenSelected? CrossFadeState.showSecond: CrossFadeState.showFirst, duration: Duration(seconds: 1)),

              )
            ),
          ),
          Expanded(
            child: Container(child:MaterialButton(onPressed: () {
              selectScreen(3);
            },
              child:AnimatedCrossFade(firstChild: icons[3], secondChild: gradientIcons[3], crossFadeState: documentsScreensSelected? CrossFadeState.showSecond: CrossFadeState.showFirst, duration: Duration(seconds: 1)),

            )),
          ),
          Expanded(
            child: Container(
              child:MaterialButton(onPressed: () {
                selectScreen(4);
              },
                child: AnimatedCrossFade(firstChild: icons[4], secondChild: gradientIcons[4], crossFadeState: profileScreenSelected? CrossFadeState.showSecond: CrossFadeState.showFirst, duration: Duration(seconds: 1)),

              ),
            ),
          ),
      ],
    )),
        ));
  }
}
