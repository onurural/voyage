// ignore_for_file: must_be_immutable, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  late final double initialValue;
  final Function(double,double) onChanged;
  // ignore: prefer_typing_uninitialized_variables
  late var value;


  CustomSlider(this.initialValue, this.onChanged, this.value, {super.key});

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
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
        value: _currentValue,
        min: 1,
        max: 5,
        divisions: 4,
        activeColor: const Color.fromRGBO(44, 87, 116, 100),
        inactiveColor: Colors.grey.shade300,
        onChanged:(double value) {
          setState(() {
            _currentValue = value;
            widget.value=value;

          });
          widget.onChanged(value,widget.value);

        },

      ),
    );
  }
}