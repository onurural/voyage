import 'dart:io';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:voyage/ui-components/custom-error-dialog.dart';

import '../../bloc/auth/auth.block.dart';
import '../../bloc/auth/auth.event.dart';
import '../../bloc/auth/auth.state.dart';
import '../../data/auth.data.dart';
import '../../views/main-connector.dart';

class SignupWidget extends StatefulWidget {
  final Function(double) onNavigate;



  SignupWidget(this.onNavigate);

  @override
  _SignupWidgetState createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  final AuthBloc _authBloc = AuthBloc();
  final AuthData _authData = AuthData();
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _onLoginButtonPressed() {
    widget.onNavigate(1);
  }

  void _onSignupButtonPressed() {
    if (_formKey.currentState!.validate()) {
      _authBloc.add(SignUpRequest(_email, _password));
    }
  }

  Widget signUpButton() {
    return BlocProvider(
      create: (_) => _authBloc,
      child: MaterialButton(
          color: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Register',
                  style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.w800)),
                ),
                BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccessState) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainConnector()),
                        );
                        var userId = _authData.getCurrentUserId();
                        _authBloc.add(SaveUserToMongoDB(_email, userId!, _password));
                      } else if (state is AuthFailedState) {
                        showErrorDialog(context,
                            'It looks like the email is existed please use another email address');
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
            _onSignupButtonPressed();
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    const Text('Sign Up', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
    const SizedBox(height: 40),
    Form
      (
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(fontSize: 18),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            ),
            onChanged: (value) {
              _email = value;
            },
            validator: (value) {
              if (!EmailValidator.validate(value!)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(fontSize: 18),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            ),
            onChanged: (value) {
              _password = value;
            },
            validator: (value) {
              if (value!.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: getImage,
                icon: Icon(Icons.photo_camera),
                label: Text("Upload Picture"),
              ),
              _image == null
                  ? Text('No image selected.')
                  : Image.file(_image!, height: 50, width: 50),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    ),
      signUpButton(),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Already have an account?'),
          TextButton(
            onPressed: _onLoginButtonPressed,
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
        ],
      ),
    ],
    ),
        ),
    );
  }
}