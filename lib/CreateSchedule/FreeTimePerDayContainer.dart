import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FreeTimePerDayContainer extends StatefulWidget {

 late var _startTime;
 late var _endTime;
 late var _timeDifference;
 bool unlocked;
 final void Function(int) unlockNext;
 int index;


 FreeTimePerDayContainer(this.unlocked, this.unlockNext, this.index);

  @override
  State<FreeTimePerDayContainer> createState() => _FreeTimePerDayContainerState();
}

class _FreeTimePerDayContainerState extends State<FreeTimePerDayContainer> {
  var _startTime;
 var _endTime;
  var _timeDifference;
  bool isFinished = false;
  bool isContentShown = false;
  var buttonIcon = Icons.add_circle;

  void _showTimeRangePicker(BuildContext context) async {
    _startTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (_startTime != null) {
      _endTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
    }

    if (_startTime != null && _endTime != null) {
      setState(() {
        final start = _startTime.hour  + _startTime.hour;
        final end = _endTime.hour  + _endTime.hour;
        _timeDifference = Duration(hours: start-end);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: widget.unlocked,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(44, 87, 116, 100
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        isContentShown = !isContentShown;
                        if (isFinished == true) {
                          buttonIcon = Icons.check_circle;
                        }
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Trip Dates',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Icon(
                          buttonIcon,
                          size: 25,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  AnimatedCrossFade(
                    firstChild: Container(),
                    secondChild: Column(
                      children: [
                        GestureDetector(
                          onTap: () => _showTimeRangePicker(context),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.access_time, color: Color.fromRGBO(44, 87, 116, 100
                                )),
                                SizedBox(width: 8),
                                Text(
                                  _startTime == null || _endTime == null
                                      ? 'Select availability hours'
                                      : '${_startTime.format(context)} - ${_endTime.format(context)}',
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(color: Color.fromRGBO(44, 87, 116, 100
                                    ), fontSize: 16,fontWeight: FontWeight.w600)
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_drop_down, color: Color.fromRGBO(44, 87, 116, 100
                                )),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isFinished = true;
                                buttonIcon = Icons.check_circle;
                                isContentShown=false;
                                widget._startTime=_startTime;
                                widget._endTime=_endTime;
                                widget._timeDifference=_timeDifference;
                                widget.unlockNext(widget.index+1);

                              });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(44, 87, 116, 100),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Apply',
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

                      ],
                    ),
                    crossFadeState: isContentShown
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                  )
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}
