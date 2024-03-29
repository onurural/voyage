// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RenameDialog extends StatefulWidget {
  final String initialName;

  void showRenameDialog(BuildContext context, String initialName) {
    showDialog(
      context: context,
      builder: (BuildContext context) => RenameDialog(initialName),
    );
  }
  const RenameDialog(this.initialName, {super.key});

  @override
  State<RenameDialog> createState() => _RenameDialogState();
}

class _RenameDialogState extends State<RenameDialog> {
  late TextEditingController _controller;
  var errorText=Text('Please Provide A Name for The Document',style: GoogleFonts.poppins(

  ),);
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName);
  }
  bool errorAppeared=false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _contentBox(context),
    );
  }

  Widget _contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color.fromRGBO(44, 87, 116, 100), Colors.grey],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'New name' ,labelStyle: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                  )
                )),
              ),
              AnimatedCrossFade(firstChild: Container(), secondChild: errorText , crossFadeState: errorAppeared ? CrossFadeState.showSecond : CrossFadeState.showFirst, duration: const Duration(milliseconds: 250)),


              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () {

                     if(_controller.text.isNotEmpty){
                       Navigator.pop(context, _controller.text);
                     }
                     else{
                     setState(() {
                       errorAppeared=true;
                     });
                     }
                    },
                    child: const Text(
                      'Apply',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showRenameDialog(BuildContext context, String initialName) {
    showDialog(
      context: context,
      builder: (BuildContext context) => RenameDialog(initialName),
    );
  }
}