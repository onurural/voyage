// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/ui-components/custom-error-dialog.dart';

import '../../bloc/auth/auth.bloc.dart';
import '../../bloc/auth/auth.event.dart';
import '../../bloc/auth/auth.state.dart';


class ForgotPasswordWidget extends StatefulWidget {
  final Function(double) onNavigate;



  const ForgotPasswordWidget(this.onNavigate, {super.key});

  @override
  _ForgotPasswordWidgetState createState() => _ForgotPasswordWidgetState();
}

class _ForgotPasswordWidgetState extends State<ForgotPasswordWidget> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';

  void _onLoginButtonPressed() {
    widget.onNavigate(1);
  }

  void _onResetPasswordButtonPressed() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(ForgotPasswordRequest(_email));

    }
  }

  @override
  Widget build(BuildContext context) {
    
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoadingState) {

          } else if (state is AuthSuccessState) {
            showErrorDialog(context, 'An Email Has Been Sent Successfully To your Provided Email ');

          } else if (state is AuthFailedState) {
           showErrorDialog(context, 'Your Provided Email Is Not Existed');
          }
        },
        child: content()
    );
  }

  SingleChildScrollView content() {
    return SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text('Forgot Password', style: GoogleFonts.poppins(textStyle: (const TextStyle(fontSize: 32, fontWeight: FontWeight.bold))),),
          const SizedBox(height: 40),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(80, 120, 150, 1), width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(80, 120, 150, 1), width: 2.0),
                    ),
                    errorBorder:   OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red,width: 2.0),
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
              ],
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: _onLoginButtonPressed,
            child: const Text('Back to Login'),
          ),
          const SizedBox(height: 20),
          MaterialButton(

            onPressed: _onResetPasswordButtonPressed,
            child: Container(decoration: (const BoxDecoration (color: Color.fromRGBO(80, 120, 150, 1),)),child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:  Text('Reset Password' , style: GoogleFonts.poppins(textStyle:const TextStyle(
                color: Colors.white,

              ) ),),
            ),),

          ),
        ],
      ),
    ),
  );
  }
}
