import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/bloc/autocomplete/autocomplete.bloc.dart';
import 'package:voyage/ui-components/create-schedule/budget-container.dart';
import 'package:voyage/ui-components/create-schedule/cities-search-bar.dart';
import 'package:voyage/ui-components/create-schedule/completed-item.dart';
import 'package:voyage/ui-components/create-schedule/create-schedule-process-indicator.dart';
import 'package:voyage/ui-components/create-schedule/date-begin-end-container.dart';
import 'package:voyage/ui-components/create-schedule/free-time-per-day-container.dart';
import 'package:voyage/ui-components/create-schedule/interest-container.dart';
import 'package:voyage/ui-components/create-schedule/trip-companions-container.dart';
import 'package:voyage/ui-components/custom-error-dialog.dart';
import 'package:voyage/views/select-place.view.dart';

import '../ui-components/place-components/hero_dialog_route.dart';


class CreateScheduleScreen extends StatefulWidget {
  const CreateScheduleScreen({Key? key}) : super(key: key);

  @override
  State<CreateScheduleScreen> createState() => _CreateScheduleScreenState();
}

class _CreateScheduleScreenState extends State<CreateScheduleScreen> with TickerProviderStateMixin {

  bool doubleToBool(double value) {
    if (value == 0.0) {
      return false;
    } else {
      return true;
    }
  }
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

var searchBar=SearchBarView();

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
      secondChild: CompletedItem('Date', onRestore, 0),
      crossFadeState: shownInRow.value[0]
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 1500),
    ),
    AnimatedCrossFade(
      firstChild: Container(),
      secondChild:   CompletedItem('Free-Time', onRestore, 1),
      crossFadeState: shownInRow.value[1]
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 1500),
    ),
    AnimatedCrossFade(
      firstChild: Container(),
      secondChild:      CompletedItem('Budget', onRestore, 2),
      crossFadeState: shownInRow.value[2]
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 1500),
    ),
    AnimatedCrossFade(
      firstChild: Container(),
      secondChild:      CompletedItem('Trip Companions', onRestore, 3),
      crossFadeState: shownInRow.value[3]
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 1500),
    ),
    AnimatedCrossFade(
      firstChild: Container(),
      secondChild:     CompletedItem('Interests', onRestore, 4),
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

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 60, 10, 20),
          child: Container(
            height: 70,
          padding: const EdgeInsets.all(16.0),

          child:   UniqueProgressIndicator(indicatorValue),
      ),
        ),

             Padding(
              padding: const EdgeInsets.all(10),
              child: BlocProvider<AutocompleteBloc>(
                create: (context) => AutocompleteBloc(),
                child: searchBar,
              ),
            ),
            SizedBox(

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
             return   _buildAnimatedCrossFade(Container(),  Column(
               children: [
                 const Divider(
                   color:     Color.fromRGBO(211, 211, 211,30),
                   thickness: 3,
                 ),
                 Padding(
                   padding: const EdgeInsets.fromLTRB( 8, 300, 8, 0),
                   child: Hero(
                     tag: 'screen1',
                     child: ElevatedButton(
                       onPressed: () {
                         if (searchBar.cityName.isNotEmpty) {
                           Navigator.of(context).push(
                             HeroDialogRoute(
                               builder: (context) =>
                                   SelectPlaceScreen(cityName: searchBar.cityName,
                                     entertainment: doubleToBool((listWidgets[4] as InterestContainer)
                                         .preferences['entertainment']! ),
                                     gastronomy:  doubleToBool((listWidgets[4] as InterestContainer)
                                         .preferences['gastronomy']!),
                                     health:  doubleToBool((listWidgets[4] as InterestContainer)
                                         .preferences['health']!),
                                     shopping: doubleToBool((listWidgets[4] as InterestContainer)
                                         .preferences['shopping']!),
                                     history: doubleToBool((listWidgets[4] as InterestContainer)
                                         .preferences['history']!),
                                     nature:  doubleToBool((listWidgets[4] as InterestContainer)
                                         .preferences['nature']!),
                                     sport: doubleToBool((listWidgets[4] as InterestContainer)
                                         .preferences['sport']!),
                                     beginDate: (listWidgets[0] as DateBeginEndContainer)
                                         .startDate,
                                     endDate: (listWidgets[0] as DateBeginEndContainer)
                                         .endDate,
                                     beginTime: (listWidgets[1] as FreeTimePerDayContainer)
                                         .beginTime,
                                     endTime: (listWidgets[1] as FreeTimePerDayContainer)
                                         .endTime,
                                     budget: (listWidgets[2] as BudgetContainer)
                                         .budgetValue,
                                     companion: (listWidgets[3] as TripCompanionsContainer)
                                         .companion,),
                               settings:  const RouteSettings(),
                               fullscreenDialog: true,
                             ),
                           );
                         }
                         else{
                           showErrorDialog(context, "Please Select a City");
                         }
                       },
                       style: ElevatedButton.styleFrom(
                         backgroundColor: const Color.fromRGBO(24, 42, 64, 1),



                       padding: const EdgeInsets
                             .symmetric(
                             vertical: 16),
                         shape: RoundedRectangleBorder(
                           borderRadius:
                           BorderRadius.circular(30),
                         ),
                       ),
                       child: Center(
                         child: Text(
                           'Create Your Schedule',
                           style: GoogleFonts.poppins(
                             textStyle: const TextStyle(
                               fontSize: 20,
                               fontWeight: FontWeight.w700,
                               color: Colors.white,
                             ),
                           ),
                         ),
                       ),
                     ),
                   ),
                 ),
               ],
             ), started ==true );
           });
         })
          ],
        ),
      ),
    );
  }

}