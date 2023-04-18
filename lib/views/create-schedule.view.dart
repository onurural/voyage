import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/ui-components/create-schedule/budget-container.dart';
import 'package:voyage/ui-components/create-schedule/completed-item.dart';
import 'package:voyage/ui-components/create-schedule/create-schedule-process-indicator.dart';
import 'package:voyage/ui-components/create-schedule/date-begin-end-container.dart';
import 'package:voyage/ui-components/create-schedule/free-time-per-day-container.dart';
import 'package:voyage/ui-components/home-view-components/search-bar.dart';

import '../ui-components/create-schedule/interest-container.dart';
import '../ui-components/create-schedule/trip-companions-container.dart';

class CreateScheduleScreen extends StatefulWidget {
  const CreateScheduleScreen({Key? key}) : super(key: key);

  @override
  State<CreateScheduleScreen> createState() => _CreateScheduleScreenState();
}

class _CreateScheduleScreenState extends State<CreateScheduleScreen> with TickerProviderStateMixin {

List<int> correctingIssuesList=[0,0,0,0,0];
var finishedTitles=['Date','Free-Time','Budget','Trip Companions','Interests'];
late double indicatorValue;
  void unlockNext(index) {
    setState(() {
      locked[index].value=true;
      if(correctingIssuesList[index] ==0){
        indicatorValue+=0.2;
      }
      correctingIssuesList[index]+=1;
      locked[index+1].value=false;
      started[index+1].value=true;




    });

  }

  void onFinish(BuildContext context, int index) {
    setState(() {
      shownInColumn.value[index]=false;
      shownInRow.value[index]=true;

    });

  }

  void onRestore(int index) {
    setState(() {
      shownInColumn.value[index]=true;
      shownInRow.value[index]=false;
      locked[index].value=false;
    });
  }



  List<Widget> finishedWidgets =[];
  List<Widget> listWidgets = [];
  List<Widget> unfinishedWidgets=[];
  var locked=[ValueNotifier(false),ValueNotifier(true),ValueNotifier(true),ValueNotifier(true),ValueNotifier(true),ValueNotifier(true),];
  var started=[ValueNotifier(true),ValueNotifier(false),ValueNotifier(false),ValueNotifier(false),ValueNotifier(false),ValueNotifier(false)];

  ValueNotifier<List<bool>> shownInColumn = ValueNotifier<List<bool>>([true, true, true, true, true]);
  ValueNotifier<List<bool>> shownInRow = ValueNotifier<List<bool>>([false, false, false, false, false]);


  void fillInFinished(){
  finishedWidgets.addAll([
    AnimatedCrossFade(
      firstChild: Container(),
      secondChild: CompletedItem("Date", onRestore, 0),
      crossFadeState: shownInRow.value[0]
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 1500),
    ),
    AnimatedCrossFade(
      firstChild: Container(),
      secondChild:   CompletedItem("Free-Time", onRestore, 1),
      crossFadeState: shownInRow.value[1]
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 1500),
    ),
    AnimatedCrossFade(
      firstChild: Container(),
      secondChild:      CompletedItem("Budget", onRestore, 2),
      crossFadeState: shownInRow.value[2]
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 1500),
    ),
    AnimatedCrossFade(
      firstChild: Container(),
      secondChild:      CompletedItem("Trip Companions", onRestore, 3),
      crossFadeState: shownInRow.value[3]
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 1500),
    ),
    AnimatedCrossFade(
      firstChild: Container(),
      secondChild:     CompletedItem("Interests", onRestore, 4),
      crossFadeState: shownInRow.value[4]
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 1500),
    ),






  ]);
  }
  List<Widget> widgetsWithAnimation=[];
  void fillInUnFinished(){
    for(int i=0;i<=4;i++){
      widgetsWithAnimation.add( AnimatedCrossFade(
        firstChild: Container(),
        secondChild: listWidgets[i],
        crossFadeState: shownInColumn.value[i]
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 300),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    indicatorValue=0;
    listWidgets = [
      DateBeginEndContainer(
          locked[0], unlockNext, 0, started[0], onFinish
          ),
      FreeTimePerDayContainer(
          locked[1], unlockNext, 1, started[1], onFinish,
         ),
      BudgetContainer(locked[2], unlockNext, 2, started[2], onFinish,
          ),
      TripCompanionsContainer(
          locked[3], unlockNext, 3, started[3], onFinish,
          ),
      InterestContainer(
          locked[4], unlockNext, 4, started[4], onFinish,
        ),
    ];
    shownInColumn.value = [true, true, true, true, true];
    shownInRow.value = [false, false, false, false, false];
    fillInFinished();
    fillInUnFinished();

  }

  Widget _buildAnimatedCrossFade(Widget firstChild, Widget secondChild, bool crossFadeState) {
    return AnimatedCrossFade(
      firstChild: firstChild,
      secondChild: secondChild,
      crossFadeState: crossFadeState ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 300),
    );
  }
void _updateProgressValue() {
  setState(() {
    indicatorValue += 0.2;

  });
}

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
        Padding(
          padding: EdgeInsets.fromLTRB(10, 60, 10, 20),
          child: Container(
            height: 70,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8.0,
                offset: Offset(0, 4),
              ),
            ],
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.9),
                Colors.white.withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child:   UniqueProgressIndicator(indicatorValue),
      ),
        ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: SearchBar([]),
            ),
            Container(

              width: MediaQuery.of(context).size.width,
              child: Wrap(
                spacing:1,
                runSpacing:1,
                children: [
                  for (int i = 0; i < 5; i++)
                    _buildAnimatedCrossFade(
                      Container(),
                      CompletedItem(finishedTitles[i], onRestore, i),
                      shownInRow.value[i],
                    ),
                ],

              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: listWidgets
                  .asMap()
                  .entries
                  .map(
                    (entry) => _buildAnimatedCrossFade(
                  Container(),
                  entry.value,
                  shownInColumn.value[entry.key],
                ),
              )
                  .toList(),
            ),

         ValueListenableBuilder(valueListenable: locked[5], builder: (context,locked,child){
           return ValueListenableBuilder(valueListenable: started[5], builder: (context,started,child){
             return   _buildAnimatedCrossFade(Container(),  Padding(
               padding: const EdgeInsets.all(8.0),
               child: ElevatedButton(
                 onPressed: () {

                 },
                 style: ElevatedButton.styleFrom(
                   primary: const Color.fromRGBO(
                       44, 87, 116, 100),
                   padding: const EdgeInsets
                       .symmetric(
                       vertical: 16),
                   shape: RoundedRectangleBorder(
                     borderRadius:
                     BorderRadius.circular(5),
                   ),
                 ),
                 child: Center(
                   child: Text(
                     'Create Your Schedule',
                     style: GoogleFonts.poppins(
                       textStyle: TextStyle(
                         fontSize: 20,
                         fontWeight: FontWeight.w700,
                         color: Colors.white,
                       ),
                     ),
                   ),
                 ),
               ),
             ), started ==true );
           });
         })
          ],
        ),
      ),
    );
  }
}