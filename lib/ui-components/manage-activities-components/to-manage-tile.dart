import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../schedule-screen-components/Activity.dart';

class ToManageActivityTile extends StatefulWidget {
  Activity activity;
  final Function onPressed;
  int index;
  final ValueNotifier<bool> isRemovedNotifier;



  ToManageActivityTile(
      this.activity, this.onPressed, this.index, this.isRemovedNotifier);

  @override
  State<ToManageActivityTile> createState() => _ToManageActivityTileState();
}

class _ToManageActivityTileState extends State<ToManageActivityTile> {
  double _opacity = 1.0;
  bool _isAnimating = false;

  void _fadeOut() async {
    if (_isAnimating) return;
    _isAnimating = true;
    setState(() {
      _opacity = 0.0;
    });
    await Future.delayed(Duration(milliseconds: 300));
    widget.isRemovedNotifier.value = true;
    _isAnimating = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        bool result = await widget.onPressed(widget.index);
        print('onAddActivity result: $result');
        if (result) {
          _fadeOut();
          widget.isRemovedNotifier.value=true;
        }
      },
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: Duration(milliseconds: 300),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            gradient: const LinearGradient(colors: [
              Color.fromRGBO(44, 87, 116, 100),
              Colors.grey
            ]),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(widget.activity.title ?? 'null',
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ))),
        ),
      ),
    );
  }
}