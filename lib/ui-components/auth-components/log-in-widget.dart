// ignore_for_file: file_names, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';



import 'package:voyage/ui-components/custom-error-dialog.dart';

import '../../bloc/auth/auth.bloc.dart';
import '../../bloc/auth/auth.event.dart';
import '../../bloc/auth/auth.state.dart';
import '../../views/main-connector.dart';

class LoginWidget extends StatefulWidget {
  final Function(double) onNavigate;

  LoginWidget(this.onNavigate, {super.key});

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget>  with TickerProviderStateMixin {


  bool _isPasswordHidden = true;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _controller = AnimationController(vsync: this);

  }
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  final AuthBloc _authBloc = AuthBloc();
  late final AnimationController _controller;
  void _onSignUpButtonPressed() {
    widget.onNavigate(0);
  }

  void _onForgotPasswordButtonPressed() {
    widget.onNavigate(2);
  }

  void _onLoginButtonPressed() {
    if (_formKey.currentState!.validate()) {

      setState(() {
        isLoading = true; // Start loading immediately before adding event
      });
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
                    Future.delayed(const Duration(seconds: 5), () { // Add delay here
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainConnector(),
                        ),
                      );
                    });
                  }
                  if (state is AuthFailedState) {
                    setState(() {
                      isLoading=false;
                    });
                    showErrorDialog(
                        context, 'The Email or the password is not correct');
                  }
                  if (state is AuthLoadingState) {

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
                        textStyle: const TextStyle(
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
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(80, 120, 150, 1),
                                width: 2.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(80, 120, 150, 1),
                                width: 2.0),
                          ),
                          errorBorder: const OutlineInputBorder(
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
    obscureText: _isPasswordHidden, // use _isPasswordHidden here
    decoration: InputDecoration(
    labelText: 'Password',
    labelStyle: GoogleFonts.poppins(),
    focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(
    color: Color.fromRGBO(80, 120, 150, 1),
    width: 2.0),
    ),
    enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(
    color: Color.fromRGBO(80, 120, 150, 1),
    width: 2.0),
    ),
    errorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2.0),
    ),
    suffixIcon: IconButton( // Add this block
    icon: Icon(
    _isPasswordHidden ? Icons.visibility : Icons.visibility_off,
    ),
    onPressed: () {
    setState(() {
    _isPasswordHidden = !_isPasswordHidden;
    });
    },
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
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Lottie.asset(
          'assets/Images/LoadingAnimation.json',
          controller: _controller,
          onLoaded: (composition) {

            _controller
              ..duration = composition.duration
              ..forward();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

}
