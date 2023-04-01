
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MatrixElement extends StatefulWidget {
  final String title;
  late double rate;
  bool isChanged = false;

  MatrixElement({required this.title, Key? key}) : super(key: key);

  @override
  State<MatrixElement> createState() => _MatrixElementState();
}

class _MatrixElementState extends State<MatrixElement> {
  double rate = 0;
  late List<IconData> icons;
  late List<String> labels;
  late Color activeTrackColor;
  late Color inactiveTrackColor;
  late Color thumbColor;
  late Color overlayColor;
  late IconData shownIcon;
  late String shownLabel;
  List<LinearGradient> gradientDecorations = [];
  var selectedGradient;

  @override
  void initState() {
    super.initState();
    icons = [
      Icons.sentiment_very_dissatisfied,
      Icons.sentiment_dissatisfied,
      Icons.sentiment_neutral,
      Icons.sentiment_satisfied,
      Icons.sentiment_very_satisfied,
    ];
    labels = [
      'Very Dissatisfied',
      'Dissatisfied',
      'Neutral',
      'Satisfied',
      'Very Satisfied',
    ];
    activeTrackColor = Colors.blue;
    inactiveTrackColor = Colors.grey;
    thumbColor = Colors.blue;
    overlayColor = Colors.transparent;
    shownIcon = icons[2];
    shownLabel = labels[2];
    gradientDecorations = [
      const LinearGradient(
          colors: [Colors.red, Colors.grey],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight),
      const LinearGradient(
          colors: [Colors.redAccent, Colors.grey],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight),
      const LinearGradient(
          colors: [Colors.amber, Colors.grey],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight),
      const LinearGradient(
          colors: [Colors.lightGreen, Colors.grey],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight),
      const LinearGradient(
          colors: [Colors.green, Colors.grey],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight),
    ];
    selectedGradient = gradientDecorations[2];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: selectedGradient,
          borderRadius: BorderRadius.circular(15), // Set border radius
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 5, 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 150,
                height: 50,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    widget.title,
                    style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SliderTheme(
                      data: SliderThemeData(
                        trackHeight: 4.0,
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: Colors.white.withOpacity(0.5),
                        thumbColor: Colors.white,
                        thumbShape:
                            const RoundSliderThumbShape(enabledThumbRadius: 12.0),
                        overlayColor: overlayColor,
                        overlayShape:
                            const RoundSliderOverlayShape(overlayRadius: 28.0),
                      ),
                      child: Slider(
                        value: rate,
                        min: -1,
                        max: 1,
                        divisions: icons.length - 1,
                        onChanged: (double value) {
                          setState(() {
                            widget.isChanged = true;
                            rate = value;
                            widget.rate = rate;
                            int index = ((rate + 1) * 2).toInt();
                            shownIcon = icons[index];
                            shownLabel = labels[index];
                            selectedGradient = gradientDecorations[index];
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          shownIcon,
                          size: 28.0,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          shownLabel,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
