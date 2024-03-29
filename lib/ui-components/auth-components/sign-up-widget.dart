// ignore_for_file: file_names, library_private_types_in_public_api, prefer_interpolation_to_compose_strings

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import 'package:voyage/ui-components/custom-error-dialog.dart';

import '../../bloc/auth/auth.bloc.dart';
import '../../bloc/auth/auth.event.dart';
import '../../bloc/auth/auth.state.dart';
import '../../views/main-connector.dart';

class SignupWidget extends StatefulWidget {
  final Function(double) onNavigate;



  const SignupWidget(this.onNavigate, {super.key});

  @override
  _SignupWidgetState createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget>  with TickerProviderStateMixin{
  bool _isPasswordHidden = true;
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
            // Configure the AnimationController with the duration of the
            // Lottie file and start the animation.
            _controller
              ..duration = composition.duration
              ..forward();
          },
        ),
      ),
    );
  }
  late final AnimationController _controller;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _firstName = '';
  String _lastName = '';
  bool isLoading = false;
  final AuthBloc _authBloc = AuthBloc();
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  void _onLoginButtonPressed() {
    widget.onNavigate(1);
  }

  void _onSignupButtonPressed() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true; // Start loading immediately before adding event
      });
      _authBloc.add(SignUpRequest(_email, _password));
    }
  }

  Widget signUpButton() {
    return BlocProvider(
      create: (_) => _authBloc,
      child: MaterialButton(
          color: const Color.fromRGBO(80, 120, 150, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'Register',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.w800)),
                    ),
                  ),
                ),
                BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccessState) {
                        Future.delayed(const Duration(seconds: 5), () { // Add delay here
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainConnector(),
                            ),
                          );
                        });
                        // var userId = _authData.getCurrentUserId();
                        _authBloc.add(SaveUserToMongoDB(_email, _firstName.replaceAll(' ', '_')+'_'+_lastName.replaceAll(' ', '_'), _password));
                      } else if (state is AuthFailedState) {
                        setState(() {
                          isLoading=false;
                        });
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
    return Stack(
      children: [
        SingleChildScrollView(
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
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                          labelStyle: TextStyle(fontSize: 18),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          _firstName = value;
                        },
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            labelText: 'Last Name',
                            labelStyle: TextStyle(fontSize: 18),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            _lastName = value;
                          },
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
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
    obscureText: _isPasswordHidden,
    decoration: InputDecoration(
    labelText: 'Password',
    labelStyle: const TextStyle(fontSize: 18),
    border: const OutlineInputBorder(),
    focusedBorder: const OutlineInputBorder(),
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
                    icon: const Icon(Icons.photo_camera),
                    label: const Text('Upload Profile Picture'),
                  ),
                  _image == null
                      ? const Text('No image.', style: TextStyle(color : Colors.blueGrey),)
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
}