// ignore_for_file: prefer_typing_uninitialized_variables, file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/ui-components/custom-error-dialog.dart';

class FreeTimePerDayContainer extends StatefulWidget {
  ValueNotifier<bool> locked;

  final void Function(int) unlockNext;
  int index;
  bool isFinished = false;
  final Function(BuildContext, int) onFinish;
  ValueNotifier<bool> started;

  FreeTimePerDayContainer(
      this.locked, this.unlockNext, this.index, this.started, this.onFinish,
      {super.key});

  @override
  State<FreeTimePerDayContainer> createState() =>
      _FreeTimePerDayContainerState();
}

class _FreeTimePerDayContainerState extends State<FreeTimePerDayContainer> {
  var _startTime;
  var _endTime;

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
    image: const DecorationImage(
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
String startText = ' ';
String endText = ' ';

  void _showTimeRangePicker(BuildContext context) async {
    TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color.fromRGBO(44, 87, 116, 1),
            colorScheme: ThemeData.light().colorScheme.copyWith(
              primary: const Color.fromRGBO(44, 87, 116, 1),
              onPrimary: Colors.white,
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedStartTime != null) {
      // ignore: use_build_context_synchronously
      TimeOfDay? pickedEndTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: const Color.fromRGBO(44, 87, 116, 1),
              colorScheme: ThemeData.light().colorScheme.copyWith(
                primary: const Color.fromRGBO(44, 87, 116, 1),
                onPrimary: Colors.white,
              ),
              buttonTheme: const ButtonThemeData(
                textTheme: ButtonTextTheme.primary,
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedEndTime != null) {
        setState(() {
          _startTime = pickedStartTime;
          _endTime = pickedEndTime;

          // Update the text
          startText = _startTime.format(context);
          endText = _endTime.format(context);
        });
      }
    }
  }




  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: widget.locked,
        builder: (context, locked, child) => ValueListenableBuilder<bool>(
        valueListenable: widget.started,
        builder: (context, started, child) => AbsorbPointer(
        absorbing: (locked && !started),
        child: Column(children: [
        Padding(
        padding: const EdgeInsets.all(10),
        child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Free-Time Per Day',
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
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.access_time,
                        color: Color.fromRGBO(
                            44, 87, 116, 100)),
                    const SizedBox(width: 8),
                    Text(
                      startText == ' ' || endText == ' '
                          ? 'Select availability hours'
                          : '$startText - $endText',
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          color: Color.fromRGBO(
                              44, 87, 116, 100),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_drop_down,
                        color: Color.fromRGBO(
                            44, 87, 116, 100)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_startTime != null &&
                        _endTime != null) {
                      widget.isFinished = true;
                      buttonIcon = Icons.done_outline_outlined;

                      widget.unlockNext(widget.index);
                      widget.onFinish(
                          context, widget.index);
                    } else {
                      showErrorDialog(context,
                          'Please Select The Beginning and Ending Time for your trip ');
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(
                      44, 87, 116, 100),
                  padding: const EdgeInsets.symmetric(
                      vertical: 16),
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
        crossFadeState: !widget.locked.value
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 300),
      ),
    ],
    ),
        ),
        ),
        ]))));
  }
}

