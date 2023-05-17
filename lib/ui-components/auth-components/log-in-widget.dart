import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';


import 'package:voyage/ui-components/custom-error-dialog.dart';

import '../../bloc/auth/auth.bloc.dart';
import '../../bloc/auth/auth.event.dart';
import '../../bloc/auth/auth.state.dart';
import '../../views/main-connector.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  final Function(double) onNavigate;

  LoginWidget(this.onNavigate);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late Timer timer;
  var percent=20;
  void startTimer(){
    setState(() {
      timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
        print('Percent Update');
        setState(() {
          percent += 1;
          if (percent >= 100) {
            timer.cancel();
            // percent=0;
          }
        });
      });
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  final AuthBloc _authBloc = AuthBloc();

  void _onSignUpButtonPressed() {
    widget.onNavigate(0);
  }

  void _onForgotPasswordButtonPressed() {
    widget.onNavigate(2);
  }

  void _onLoginButtonPressed() {
    if (_formKey.currentState!.validate()) {
      _authBloc.add(LogInRequest(_email, _password));
    }
  }

  Widget logInButton() {
    return BlocProvider(
      create: (_) => _authBloc,
      child: MaterialButton(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Log In',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.w800)),
                ),
                BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
                  if (state is AuthSuccessState) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainConnector()),
                    );
                  }
                  if (state is AuthFailedState) {
                    setState(() {
                      isLoading=false;
                    });
                    showErrorDialog(
                        context, 'The Email or the password is not correct');
                  }
                  if (state is AuthLoadingState) {
                    startTimer();
                    setState(() {
                      isLoading = true;
                    });
                  }
                }, builder: (context, state) {
                  return const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Icon(
                      Icons.login_sharp,
                      color: Colors.white,
                      size: 20,
                    ),
                  );
                }),
              ],
            ),
          ),
          onPressed: () {
            _onLoginButtonPressed();
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Log In',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold))),
                const SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: GoogleFonts.poppins(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color.fromRGBO(80, 120, 150, 1),
                                width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color.fromRGBO(80, 120, 150, 1),
                                width: 2.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.red, width: 2.0),
                          ),
                        ),
                        onChanged: (value) => _email = value.trim(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!EmailValidator.validate(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: GoogleFonts.poppins(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color.fromRGBO(80, 120, 150, 1),
                                width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color.fromRGBO(80, 120, 150, 1),
                                width: 2.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.red, width: 2.0),
                          ),
                        ),
                        onChanged: (value) => _password = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }

                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: _onSignUpButtonPressed,
                      child: const Text('Sign Up'),
                    ),
                    TextButton(
                      onPressed: _onForgotPasswordButtonPressed,
                      child: const Text('Forgot Password?'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(80, 120, 150, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: logInButton(),
                ),
              ],
            ),
          ),
        ),

        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Center(
                child: _buildLoadingAnimation(),
              ),
            ),
          ),


      ],
    );
  }


  Widget _buildLoadingAnimation() {
    return Container(
      width: 150.0,
      height: 150.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: LiquidCustomProgressIndicator(
          value: percent / 100,
          valueColor: AlwaysStoppedAnimation( Color.fromRGBO(37, 154, 180, 1)),
          backgroundColor: Colors.grey,
          direction: Axis.vertical,
          shapePath: buildBoatPath(),
        ),
      ),
    );
  }
  Path buildBoatPath() {
    return Path()
      ..moveTo(15, 120)
      ..lineTo(0, 85)
      ..lineTo(50, 85)
      ..lineTo(50, 0)
      ..lineTo(105, 80)
      ..lineTo(60, 80)
      ..lineTo(60, 85)
      ..lineTo(120, 85)
      ..lineTo(105, 120)
      ..close();
  }
}
