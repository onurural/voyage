import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomErrorDialog extends StatelessWidget {
  final String errorText;

  const CustomErrorDialog({Key? key, required this.errorText}) : super(key: key);

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
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromRGBO(44, 87, 116, 100),Colors.grey],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.error_outline_rounded,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(height: 16),
              Text(
                errorText,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(fontSize: 16, color: Colors.white)
                ),
              ),
              SizedBox(height: 24),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

void showErrorDialog(BuildContext context, String errorText) {
  showDialog(
    context: context,
    builder: (BuildContext context) => CustomErrorDialog(errorText: errorText),
  );
}