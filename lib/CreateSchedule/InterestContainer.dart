import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'MatrixElement.dart';

class InterestContainer extends StatefulWidget {
  Map<String, double> preferences = {};
  bool isFinished = false;
  bool unlocked;
  int index;
  final void Function(int) unlockNext;


  InterestContainer(this.unlocked,  this.unlockNext,this.index,);

  @override
  State<InterestContainer> createState() => _InterestContainerState();
}

class _InterestContainerState extends State<InterestContainer> {
  bool isFinished = false;
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
  var buttonIcon = Icons.add_circle;
  int counter = 0;
  var isContentShown = false;

  @override
  void initState() {
    // TODO: implement initState
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
                isFinished = true;
                isContentShown = false;
                for (var element in matrixes) {
                  widget.preferences
                      .putIfAbsent(element.title, () => element.rate);
                }
                widget.isFinished = true;
                widget.unlockNext(widget.index+1);
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
        ),
      ],
    );

  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: widget.unlocked,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(44, 87, 116, 100),
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
                    counter++;
                    if (isFinished == true) {
                      buttonIcon = Icons.check_circle;
                    }
                  });
                },
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
                crossFadeState: isContentShown
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
