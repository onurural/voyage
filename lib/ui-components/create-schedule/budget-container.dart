import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class BudgetContainer extends StatefulWidget {
  late double budgetValue;
  ValueNotifier<bool> locked;
  final void Function(int) unlockNext;
  int index;

  bool isFinished = false;
  ValueNotifier<bool> started;

  final Function(BuildContext, int) onFinish;

  BudgetContainer(
      this.locked, this.unlockNext, this.index, this.started, this.onFinish,
      {Key? key})
      :
        super(key: key);

  @override
  _BudgetContainerState createState() => _BudgetContainerState();
}

class _BudgetContainerState extends State<BudgetContainer> {
  double _budgetValue = 5.0;

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

  String getBudgetLabel(double value) {
    if (value <= 1.0) {
      return 'Budget';
    } else if (value <= 3.0) {
      return 'Normal';
    } else {
      return 'Expensive';
    }
  }

  var buttonIcon = Icons.edit;
  var content;
  var shownIcon;
  Widget dollarIcon = const Icon(
    CupertinoIcons.money_dollar,
    color: Colors.white,
    size: 30,
  );
  late List<Widget> dollarIcons;

  @override
  void initState() {
    super.initState();

    dollarIcons = [
      dollarIcon,
      Row(children: [dollarIcon, dollarIcon]),
      Row(children: [dollarIcon, dollarIcon, dollarIcon]),
      Row(children: [dollarIcon, dollarIcon, dollarIcon, dollarIcon]),
      Row(
          children: [
            dollarIcon,
            dollarIcon,
            dollarIcon,
            dollarIcon,
            dollarIcon,
          ]),
    ];

    shownIcon = dollarIcons[0];

    content = Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getBudgetLabel(_budgetValue),
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              dollarIcons [4]
            ],
          ),
          const SizedBox(height: 16),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: const Color.fromRGBO(44, 87, 116, 100),
              inactiveTrackColor: Colors.grey.shade300,
              thumbColor: const Color.fromRGBO(44, 87, 116, 100),
              overlayColor: const Color.fromRGBO(44, 87, 116, 0.3),
              trackHeight: 4.0,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
            ),
            child: Slider(
              value: _budgetValue,
              min: 1,
              max: 5,
              divisions: 4,
              activeColor: const Color.fromRGBO(44, 87, 116, 100),
              inactiveColor: Colors.grey.shade300,
              onChanged: (double value) {
                setState(() {
                  _budgetValue = value;
                  shownIcon = dollarIcons[value.toInt() - 1];
                });
              },
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.onFinish(context, widget.index);
                widget.isFinished = true;
                buttonIcon = Icons.done_outline_outlined;
                widget.budgetValue = _budgetValue;
              });
              widget.unlockNext(widget.index);
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.locked,
      builder: (context, isLocked, _) {
        return ValueListenableBuilder<bool>(
          valueListenable: widget.started,
          builder: (context, isStarted, _) {
            return AbsorbPointer(
              absorbing: (isLocked && !isStarted),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.all(16.0),
                      decoration: isLocked && !isStarted
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
                                  'Budget',
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
                          ValueListenableBuilder<bool>(
                            valueListenable: widget.locked,
                            builder: (context, locked, child) {
                              return AnimatedCrossFade(
                                firstChild: Container(),
                                secondChild: content,
                                crossFadeState: !locked
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: const Duration(milliseconds: 300),

                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}