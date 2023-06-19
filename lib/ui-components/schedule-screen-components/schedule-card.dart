// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/bloc/schedule/schedule.bloc.dart';
import 'package:voyage/models/activity.dart' as ActivityT;


import '../../models/schedule.dart';
import '../../models/user-schedules.dart';
import '../../views/schedule-view/schedule.view.dart';

class ScheduleCard extends StatefulWidget {
  final UserSchedule schedule;
  final double? maxHeight;

  const ScheduleCard(this.schedule, {Key? key, this.maxHeight})
      : super(key: key);

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  Schedule convertToNormalSchedule(){
    List<ActivityT.Activity> tempList=[];

    for (Activity activity in widget.schedule.activities ?? []) {

     ActivityT.Activity temp=new ActivityT.Activity(beginTime: activity.beginTime, endTime: activity.endTime, day: activity.day, title: activity.title, category: activity.category, rate: activity.rate, description: activity.description, photos: [], placeID: activity.placeId, duration: Duration(minutes: activity.duration!), photosLinks: []);
     tempList.add(temp);
    }

    return Schedule(
      tempList,

      widget.schedule.userId!,
      widget.schedule.title!,
    );
  }

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: IntrinsicHeight(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: widget.maxHeight ?? double.infinity,
          ),
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                Container(

                ), // TODO handle the decoration.
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.blue.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                widget.schedule.title ?? 'null',
                                style: GoogleFonts.notoSerif(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RatingBarIndicator(
                                  rating: widget.schedule.activities?[0].rate ?? -1,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.white,
                                  ),
                                  itemCount: 5,
                                  itemSize: 15,
                                  direction: Axis.horizontal,
                                ),
                                Text(
                                  widget.schedule.activities?[0].rate.toString() ?? '-1',
                                  style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(44, 87, 116, 100),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Hero(
                        tag: widget.schedule.id!,
                        child: MaterialButton(
                          onPressed: () {

                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
                                  create: (BuildContext context) => ScheduleBloc(),
                                  child: ScheduleScreen(schedule: convertToNormalSchedule(),newCreated: false,),
                                ),
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    var begin = Offset(2.0, 0.0);
                                    var end = Offset.zero;
                                    var curve = Curves.easeInOut;

                                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                    var offsetAnimation = animation.drive(tween);

                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: FadeTransition(
                                        opacity: animation.drive(CurveTween(curve: curve)),
                                        child: ScaleTransition(
                                          scale: animation.drive(CurveTween(curve: curve)),
                                          child: child,
                                        ),
                                      ),
                                    );
                                  }
                              ),
                            );
                          },
                          child: Center(
                            child: Text(
                              'View',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
