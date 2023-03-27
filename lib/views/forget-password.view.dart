
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final List<FocusNode> _focusNodes = [
    FocusNode(),

  ];
  var activeOrDoneColor = Colors.white;
  var hintTextColor = Colors.white;
  var borderColor = const Color.fromRGBO(117, 117, 117, 100);
  var iconColor = const Color.fromRGBO(117, 117, 117, 100);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(


        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color.fromRGBO(37, 154, 180, 100), Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 60),
                child: SizedBox(width: 300,
                    child: Image.asset('assets/Images/Logo.png')),
              ),
              Form(
                  child: Stack(


                    children: [

                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Container(

                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(192, 188, 188, 100),
                              borderRadius: BorderRadius.circular(10)

                          )
                          ,child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 70, 0, 70),
                          child: Material(
                            color: Colors.transparent,
                            child: TextField(
                              focusNode: _focusNodes[0],
                              keyboardType: TextInputType.emailAddress,
                              autofillHints: const [AutofillHints.email],
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1,
                                  decoration: TextDecoration.none),
                              decoration: InputDecoration(
                                suffixIcon: const Icon(Icons.mail),
                                suffixIconColor: _focusNodes[0].hasFocus ? const Color.fromRGBO(37, 150, 190, 100) : Colors.white,
                                filled: true,
                                fillColor: Colors.transparent,
                                hintText: 'E-mail address',
                                hintStyle: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: hintTextColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                        letterSpacing: 1)),

                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 2,
                                    )),
                                focusedErrorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(37, 150, 190, 100),
                                        width: 2)),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: borderColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,

                        left: 0,
                        right: 0,
                        child: Padding(
                          padding:  const EdgeInsets.fromLTRB(80, 0, 80, 0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(37, 154, 180, 100),
                                borderRadius: BorderRadius.circular(10)

                            ),


                            child: MaterialButton(child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Register',style: GoogleFonts.openSans(
                                      textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800
                                      )
                                  ),
                                  ),

                                ],
                              ),
                            ),onPressed: (){}),
                          ),
                        ),
                      )



                    ],
                  )),




            ],

          ),
        ),
      ),
    );
  }
}
