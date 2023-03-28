import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class BudgetContainer extends StatefulWidget {
  BudgetContainer({Key? key}) : super(key: key);
  late double budgetValue;

  @override
  _BudgetContainerState createState() => _BudgetContainerState();
}

class _BudgetContainerState extends State<BudgetContainer> {
  double _budgetValue = 1.0;

  String getBudgetLabel(double value) {
    if (value <= 1.0) {
      return 'Budget';
    } else if (value <= 3.0) {
      return 'Medium';
    } else {
      return 'Expensive';
    }
  }

  bool isFinished = false;
  bool isContentShown = false;
  var buttonIcon = Icons.add_circle;
var content;
  var shownIcon;
  Widget dollarIcon = Icon(
    CupertinoIcons.money_dollar,
    color: Colors.white,
    size: 20,
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
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                getBudgetLabel(_budgetValue),
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 8),
              shownIcon,
            ],
          ),
          SizedBox(height: 16),
          Slider(
            value: _budgetValue,
            min: 1,
            max: 5,
            divisions: 4,
            onChanged: (double value) {
              setState(() {
                _budgetValue = value;
                shownIcon = dollarIcons[value.toInt() - 1];
              });
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isFinished = true;
                buttonIcon = Icons.check_circle;
                this.isContentShown=false;
                widget.budgetValue=_budgetValue;
              });
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(44, 87, 116, 100),
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Center(
              child: Text(
                "Apply",
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
        padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
    color: Color.fromRGBO(44, 87, 116, 100
    ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 8,
          offset: Offset(0, 4),
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
                      'Budget',
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
                      size: 25,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              AnimatedCrossFade(
                firstChild: Container(),
                secondChild: content,
                crossFadeState: isContentShown
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 500),
              )
            ],
          ),
        ),
    );
  }
}
