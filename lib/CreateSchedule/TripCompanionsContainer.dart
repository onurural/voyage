import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/Components/CustomErrorDialog.dart';

class TripCompanionsContainer extends StatefulWidget {
 TripCompanionsContainer({Key? key}) : super(key: key);
  late String companion;

  @override
  State<TripCompanionsContainer> createState() => _TripCompanionsContainerState();
}

class _TripCompanionsContainerState extends State<TripCompanionsContainer> {
  String? _selectedCompanion;
  var buttonIcon = Icons.add_circle;
  bool isFinished = false;
  bool isContentShown = false;
  @override
  Widget build(BuildContext context) {
    return Column(
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
                        'Trip Companions',
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
                  secondChild:  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            colors: [Color.fromRGBO(44, 87, 116, 100), Colors.grey],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: DropdownButton<String>(
                            value: _selectedCompanion,
                            hint: Text(
                              'Select trip companion',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedCompanion = newValue;
                              });
                            },
                            items: ['Friends', 'Alone', 'Partner', 'Family']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: GoogleFonts.poppins(
                                  textStyle: TextStyle(color: Colors.white, fontSize: 18)
                                )),
                              );
                            }).toList(),
                            dropdownColor: Color.fromRGBO(44, 87, 116, 100),
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(color: Colors.white, fontSize: 18)
                            ),
                            underline: SizedBox.shrink(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if(_selectedCompanion != null) {
                            setState(() {
                              isFinished = true;
                              buttonIcon = Icons.check_circle;
                              isContentShown = false;
                              widget.companion = _selectedCompanion!;
                            });
                          }
                          else{
                           showErrorDialog(context, "Please Select Your Companion");

                          }
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
    );
  }
}