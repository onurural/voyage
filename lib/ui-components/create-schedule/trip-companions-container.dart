// ignore_for_file: file_names, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/ui-components/custom-error-dialog.dart';

class TripCompanionsContainer extends StatefulWidget {
  ValueNotifier<bool> locked;
  final void Function(int) unlockNext;
  late final companion;


  int index;
  bool isFinished = false;
  ValueNotifier<bool> started;
  final Function(BuildContext, int) onFinish;

  TripCompanionsContainer(
      this.locked, this.unlockNext, this.index, this.started, this.onFinish,
      {super.key});

  @override
  State<TripCompanionsContainer> createState() =>
      _TripCompanionsContainerState();
}

class _TripCompanionsContainerState extends State<TripCompanionsContainer> {
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

  String? _selectedCompanion;
  var buttonIcon = Icons.edit;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: widget.locked,
        builder: (context, locked, child) => ValueListenableBuilder<bool>(
            valueListenable: widget.started,
            builder: (context, started, child) => AbsorbPointer(
                absorbing: (locked && !started),
                child: Column(
                    children: [
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: const LinearGradient(
                                    colors:
                                    [
                                      Color.fromRGBO(44, 87, 116, 100),
                                      Colors.grey,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: Center(
                                  child: DropdownButton<String>(
                                    value: _selectedCompanion,
                                    hint: const Text(
                                      'Select trip companion',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    icon: const Icon(Icons.arrow_drop_down,
                                        color: Colors.white),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedCompanion = newValue;
                                      });
                                    },
                                    items: [
                                      'Friends',
                                      'Alone',
                                      'Partner',
                                      'Family'
                                    ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value,
                                                style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18))),
                                          );
                                        }).toList(),
                                    dropdownColor: const Color.fromRGBO(44, 87, 116, 100),
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            color: Colors.white, fontSize: 18)),
                                    underline: const SizedBox.shrink(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  if (_selectedCompanion != null) {
                                    setState(() {
                                      widget.isFinished = true;
                                      buttonIcon = Icons.done_outline_outlined;
                                    });
                                    widget.unlockNext(widget.index);
                                    widget.onFinish(context, widget.index);
                                    widget.companion=_selectedCompanion;
                                  } else {
                                    showErrorDialog(
                                        context, 'Please Select Your Companion');
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(44, 87, 116, 100),
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
    );
  }
}
