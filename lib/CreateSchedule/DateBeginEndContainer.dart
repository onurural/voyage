import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DateBeginEndContainer extends StatefulWidget {

  late var startDate;
  late var endDate;
   bool unlocked;
  final void Function(int) unlockNext;
  int index;


  DateBeginEndContainer(this.unlocked, this.unlockNext, this.index);

  @override
  State<DateBeginEndContainer> createState() => _DateBeginEndContainerState();
}

class _DateBeginEndContainerState extends State<DateBeginEndContainer> {
 var _startDate;
  var _endDate;
 bool isFinished = false;
 bool isContentShown = false;
 var buttonIcon = Icons.add_circle;
  void _showDateRangePicker(BuildContext context) async {
    final dateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (dateRange != null) {
      setState(() {
        _startDate = dateRange.start;
        _endDate = dateRange.end;
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
                    secondChild: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => _showDateRangePicker(context),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(Icons.calendar_today, color: const Color.fromRGBO(44, 87, 116, 100
                                      )),
                                      const SizedBox(width: 8),
                                      Text(
                                        _startDate == null || _endDate == null
                                            ? 'Click For Choosing Trip Dates'
                                            : '${DateFormat('MMM d, y').format(_startDate)} - ${DateFormat('MMM d, y').format(_endDate)}',
                                        style: GoogleFonts.openSans(
                                            textStyle: const TextStyle(color: const Color.fromRGBO(44, 87, 116, 100
                                            ), fontSize: 14,fontWeight: FontWeight.w600)
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(Icons.arrow_drop_down, color: const Color.fromRGBO(44, 87, 116, 100
                                      )),
                                    ],
                                  ),


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
                                  widget.startDate=_startDate;
                                  widget.endDate=_endDate;
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
                          )
                        ],
                      ),
                    ),
                    crossFadeState: isContentShown
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                  )
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}