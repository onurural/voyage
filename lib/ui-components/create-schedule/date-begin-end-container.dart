import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:voyage/ui-components/custom-error-dialog.dart';

class DateBeginEndContainer extends StatefulWidget {
  ValueNotifier<bool> locked;
  final void Function(int) unlockNext;

  int index;
  bool isFinished = false;
  ValueNotifier<bool> started;
  final Function(BuildContext, int) onFinish;
  DateBeginEndContainer(
      this.locked,
      this.unlockNext,
      this.index,
      this.started,
      this.onFinish,
      {super.key});

  @override
  State<DateBeginEndContainer> createState() =>
      _DateBeginEndContainerState();
}

class _DateBeginEndContainerState extends State<DateBeginEndContainer> {
  var _startDate;
  var _endDate;
  Widget content(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                _showDateRangePicker(context),
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(12),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Color.fromRGBO(
                            44, 87, 116, 100),
                      ),
                      SizedBox(width: 8),
                      Text(
                        _startDate == null ||
                            _endDate == null
                            ? 'Click For Choosing Trip Dates'
                            : '${DateFormat(
                            'MMM d, y').format(
                            _startDate)} - ${DateFormat(
                            'MMM d, y').format(
                            _endDate)}',
                        style: GoogleFonts
                            .openSans(
                          textStyle: TextStyle(
                            color: Color.fromRGBO(
                                44, 87, 116, 100),
                            fontSize: 14,
                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Color.fromRGBO(
                            44, 87, 116, 100),
                      ),
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
                  if (_startDate != null &&
                      _endDate != null) {
                    widget.isFinished = true;
                    buttonIcon =
                        Icons.done_outline_outlined;
                    widget.unlockNext(
                        widget.index);
                    widget.onFinish(
                        context, widget.index);
                  } else {
                    showErrorDialog(
                      context,
                      'Please Fill in the Beginning and The Ending Date of The Trip ',
                    );
                  }
                });
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
                  'Apply',
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
          ),
        ],
      ),
    );
  }
  var activeDesign = BoxDecoration(
    color: const Color.fromRGBO(44, 87, 116, 100),
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
  );
  var deactivatedDesign = BoxDecoration(
    color: const Color.fromRGBO(80, 120, 150, 1), // Darker color values
    borderRadius: BorderRadius.circular(16),
    image: DecorationImage(
      image: AssetImage('assets/Images/snowflake.png'),
      fit: BoxFit.cover,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
  );

  var buttonIcon = Icons.edit;

  void _showDateRangePicker(BuildContext context) async {
    final dateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color.fromRGBO(44, 87, 116, 1),
            colorScheme: ThemeData.light().colorScheme.copyWith(
              primary: Color.fromRGBO(44, 87, 116, 1),
              onPrimary: Colors.white,
            ),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
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
    return ValueListenableBuilder<bool>(
      valueListenable: widget.locked,
      builder: (context, locked, child) =>
          ValueListenableBuilder<bool>(
            valueListenable: widget.started,
            builder: (context, started, child) =>
                GestureDetector(
                  onTap: () {
                    if (widget.isFinished) {}
                  },
                  child: AbsorbPointer(
                    absorbing: (locked && !started),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              padding: const EdgeInsets.all(16.0),
                              decoration: (locked && !started)
                                  ? deactivatedDesign
                                  : activeDesign,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          'Trip Dates',
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          buttonIcon,
                                          size:25,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  AnimatedCrossFade(
                                    firstChild: Container(),
                                    secondChild: content(),
                                    crossFadeState: !widget.locked.value
                                        ? CrossFadeState.showSecond
                                        : CrossFadeState.showFirst,
                                    duration: const Duration(milliseconds: 500),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          ),
    );
  }
}