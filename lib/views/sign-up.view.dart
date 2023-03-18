import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var activeOrDoneColor = Colors.white;
  var hintTextColor = Color.fromRGBO(117, 117, 117, 100);
  var borderColor = Color.fromRGBO(117, 117, 117, 100);
  var iconColor = Color.fromRGBO(117, 117, 117, 100);
  bool _obscureText = true;
  final _passwordController = TextEditingController();
  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    _focusNodes.forEach((node){
      node.addListener(() {
        setState(() {});
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color.fromRGBO(37, 154, 180, 100), Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(width: 300,
                  child: Image.asset("assets/Images/Logo.png")),
              Form(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: Material(
                          color: Colors.transparent,
                          child: TextField(
                            focusNode: _focusNodes[0],
                            keyboardType: TextInputType.name,
                            autofillHints: [AutofillHints.username],
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                                decoration: TextDecoration.none),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              prefixIconColor: _focusNodes[0].hasFocus ? Color.fromRGBO(37, 150, 190, 100) : Colors.white,
                              filled: true,
                              fillColor: Colors.transparent,
                              hintText: "Username",
                              hintStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: hintTextColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17,
                                      letterSpacing: 1)),

                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  )),
                              focusedErrorBorder: UnderlineInputBorder(
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Material(
                          color: Colors.transparent,
                          child: TextField(
                            focusNode: _focusNodes[0],
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: [AutofillHints.email],
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                                decoration: TextDecoration.none),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.mail),
                              prefixIconColor: _focusNodes[0].hasFocus ? Color.fromRGBO(37, 150, 190, 100) : Colors.white,
                              filled: true,
                              fillColor: Colors.transparent,
                              hintText: "E-mail address",
                              hintStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: hintTextColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17,
                                      letterSpacing: 1)),

                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  )),
                              focusedErrorBorder: UnderlineInputBorder(
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0,30),
                        child: Material(
                          color: Colors.transparent,
                          child: TextField(
                            controller: _passwordController,
                            obscureText: _obscureText,
                            focusNode: _focusNodes[1],
                            keyboardType: TextInputType.visiblePassword,
                            autofillHints: [AutofillHints.password],
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                                decoration: TextDecoration.none),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(onPressed: () { setState(() {
                                _obscureText = !_obscureText;
                              }); },  icon: Icon(
                                _obscureText ? Icons.visibility : Icons.visibility_off,
                              ),


                              ),
                              suffixIconColor: _focusNodes[1].hasFocus ? Color.fromRGBO(37, 150, 190, 100) : Colors.white ,
                              prefixIcon: Icon(Icons.lock),
                              prefixIconColor: _focusNodes[1].hasFocus ? Color.fromRGBO(37, 150, 190, 100) : Colors.white,
                              filled: true,
                              fillColor: Colors.transparent,
                              hintText: "Password",
                              hintStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: hintTextColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17,
                                      letterSpacing: 1)),

                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  )),
                              focusedErrorBorder: UnderlineInputBorder(
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

                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 0, 40, 20),
                        child: Container(

                            width: double.infinity,
                            height: 50,


                            decoration: BoxDecoration(
                                color: Color.fromRGBO(120, 148, 156, 100),
                                borderRadius: BorderRadius.circular(25)

                            ),
                            child: MaterialButton(child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Register",style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 23,
                                          fontWeight: FontWeight.w800
                                      )
                                  ),
                                  ),

                                ],
                              ),
                            ),onPressed: (){})),
                      )
                    ],
                  )),
              Text("Sign Up With",style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                      color: Color.fromRGBO(87, 99, 108, 100),
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      decoration: TextDecoration.none
                  )
              ),),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Material(color: Colors.transparent,child: IconButton(color: Color.fromRGBO(87, 99, 108, 100),onPressed: ()=>{}, icon: Icon(Icons.facebook,color: Colors.white,size: 50,))),
                    Material(color: Colors.transparent,child: IconButton(color: Color.fromRGBO(87, 99, 108, 100),onPressed: ()=>{}, icon: Icon(Icons.facebook,color: Colors.white,size: 50,))),
                    Material(color: Colors.transparent,child: IconButton(color: Color.fromRGBO(87, 99, 108, 100),onPressed: ()=>{}, icon: Icon(Icons.facebook,color: Colors.white,size: 50,))),

                  ],
                ),
              ),
              Text("Already have an account?",style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                      color: Color.fromRGBO(87, 99, 108, 100),
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      decoration: TextDecoration.none
                  )
              ),),
              MaterialButton(onPressed: ()=>{

              },child: Text(
                "Log In",style: GoogleFonts.openSans(
                  fontSize: 20,
                  color: Color.fromRGBO(248, 132, 20, 100),
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w700
              ),
              ),)
            ],

          ),
        ),
      ),
    );
  }
}
