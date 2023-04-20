import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'matrix-element.dart';

class InterestContainer extends StatefulWidget {
  Map<String, double> preferences = {};
  bool isFinished = false;
  ValueNotifier<bool> locked;

  int index;

  final void Function(int) unlockNext;
  ValueNotifier<bool> started;

  final Function(BuildContext, int) onFinish;

  InterestContainer(
      this.locked, this.unlockNext, this.index, this.started, this.onFinish,
      {super.key});

  @override
  State<InterestContainer> createState() => _InterestContainerState();
}

class _InterestContainerState extends State<InterestContainer> {

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
  var matrixes = [
    MatrixElement(title: 'Entertainment'),
    MatrixElement(title: 'Gastronomy'),
    MatrixElement(title: 'Health'),
    MatrixElement(title: 'Shopping'),
    MatrixElement(title: 'History'),
    MatrixElement(title: 'Nature'),
    MatrixElement(title: 'Sport'),
  ];
  var interests;

  @override
  void initState() {
    super.initState();
    interests = Column(
      children: [
        matrixes[0],
        matrixes[1],
        matrixes[2],
        matrixes[3],
        matrixes[4],
        matrixes[5],
        matrixes[6],
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              color: const Color.fromRGBO(44, 87, 116, 100),
              borderRadius: BorderRadius.circular(5)),
          child: MaterialButton(
            onPressed: () {
              setState(() {
                widget.isFinished = true;
                buttonIcon = Icons.done_outline_outlined;

                for (var element in matrixes) {
                  widget.preferences
                      .putIfAbsent(element.title, () => element.rate);
                }
                widget.isFinished = true;
                widget.unlockNext(widget.index);
                widget.onFinish(context, widget.index);
              });
            },
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: widget.locked,
        builder: (context, locked, child) =>
    ValueListenableBuilder<bool>(
        valueListenable: widget.started,
        builder
            : (context, started, child) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(16.0),
              decoration: locked && !started ? deactivatedDesign : activeDesign,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Interests',
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
                    secondChild: interests,
                    crossFadeState: !widget.locked.value
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 500),
                  )
                ],
              ),
            ),
          );
        },
    )
    );
  }
}