import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/bloc/auth/auth.block.dart';
import 'package:voyage/bloc/auth/auth.event.dart';
import 'package:voyage/bloc/auth/auth.state.dart';
import 'package:voyage/data/auth.data.dart';
import 'package:voyage/repository/auth.repository.dart';
import 'package:voyage/views/home-container.dart';

import 'log-in.view.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final AuthBloc _authBloc =  AuthBloc();

  var activeOrDoneColor = Colors.white;
  var hintTextColor = const Color.fromRGBO(117, 117, 117, 100);
  var borderColor = const Color.fromRGBO(117, 117, 117, 100);
  var iconColor = const Color.fromRGBO(117, 117, 117, 100);
  bool _obscureText = true;
  final _passwordController = TextEditingController();
  final List<FocusNode> _focusNodes = [
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
    for (var node in _focusNodes) {
      node.addListener(() {
        setState(() {});
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var openSans = GoogleFonts.openSans(
        textStyle: const TextStyle(
            color: Color.fromRGBO(87, 99, 108, 100),
            fontWeight: FontWeight.w500,
            fontSize: 16,
            decoration: TextDecoration.none));

    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color.fromRGBO(37, 154, 180, 100), Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                logo(),
                form(),
                Text(
                  'Sign Up With',
                  style: openSans,
                ),
                socialSign(),
                Text(
                  'Already have an account?',
                  style: openSans,
                ),
                loginButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  MaterialButton loginButton() {
    var openSansOrange = GoogleFonts.openSans(
        fontSize: 20,
        color: const Color.fromRGBO(248, 132, 20, 100),
        decoration: TextDecoration.none,
        fontWeight: FontWeight.w700);
    return MaterialButton(
      onPressed: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LogInScreen()),
        )
      },
      child: Text(
        'Log In',
        style: openSansOrange,
      ),
    );
  }

  Padding socialSign() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Material(
              color: Colors.transparent,
              child: IconButton(
                  color: const Color.fromRGBO(87, 99, 108, 100),
                  onPressed: () => {},
                  icon: const Icon(
                    Icons.facebook,
                    color: Colors.white,
                    size: 50,
                  ))),
          Material(
              color: Colors.transparent,
              child: IconButton(
                  color: const Color.fromRGBO(87, 99, 108, 100),
                  onPressed: () => {},
                  icon: const Icon(
                    Icons.facebook,
                    color: Colors.white,
                    size: 50,
                  ))),
          Material(
              color: Colors.transparent,
              child: IconButton(
                  color: const Color.fromRGBO(87, 99, 108, 100),
                  onPressed: () => {},
                  icon: const Icon(
                    Icons.facebook,
                    color: Colors.white,
                    size: 50,
                  ))),
        ],
      ),
    );
  }

  SizedBox logo() {
    return SizedBox(width: 300, child: Image.asset('assets/Images/Logo.png'));
  }

  Form form() {
    var poppins = GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 17,
        fontWeight: FontWeight.w800,
        letterSpacing: 1,
        decoration: TextDecoration.none);
    return Form(
        child: Column(
      children: [
        usernameInputField(poppins),
        emailInputField(),
        passwordInputField(),
        registerButton()
      ],
    ));
  }

  Padding passwordInputField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
      child: Material(
        color: Colors.transparent,
        child: TextField(
          controller: _passwordController,
          obscureText: _obscureText,
          focusNode: _focusNodes[1],
          keyboardType: TextInputType.visiblePassword,
          autofillHints: const [AutofillHints.password],
          style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
              decoration: TextDecoration.none),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
              ),
            ),
            suffixIconColor: _focusNodes[1].hasFocus
                ? const Color.fromRGBO(37, 150, 190, 100)
                : Colors.white,
            prefixIcon: const Icon(Icons.lock),
            prefixIconColor: _focusNodes[1].hasFocus
                ? const Color.fromRGBO(37, 150, 190, 100)
                : Colors.white,
            filled: true,
            fillColor: Colors.transparent,
            hintText: 'Password',
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
                    color: Color.fromRGBO(37, 150, 190, 100), width: 2)),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding emailInputField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
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
            prefixIcon: const Icon(Icons.mail),
            prefixIconColor: _focusNodes[0].hasFocus
                ? const Color.fromRGBO(37, 150, 190, 100)
                : Colors.white,
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
                    color: Color.fromRGBO(37, 150, 190, 100), width: 2)),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding usernameInputField(TextStyle poppins) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Material(
        color: Colors.transparent,
        child: TextField(
          focusNode: _focusNodes[0],
          keyboardType: TextInputType.name,
          autofillHints: const [AutofillHints.username],
          style: poppins,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person),
            prefixIconColor: _focusNodes[0].hasFocus
                ? const Color.fromRGBO(37, 150, 190, 100)
                : Colors.white,
            filled: true,
            fillColor: Colors.transparent,
            hintText: 'Username',
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
                    color: Color.fromRGBO(37, 150, 190, 100), width: 2)),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  BlocProvider<StateStreamableSource<Object?>> registerButton() {
    return BlocProvider(
      create: (_) => _authBloc,
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
        if (state is AuthSuccessState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeCon()),
          );
        } else if (state is AuthFailedState) {
          // Handle sign-up failure, e.g. show error message
        }
      }, 
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 20),
          child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(120, 148, 156, 100),
                  borderRadius: BorderRadius.circular(25)),
              child: MaterialButton(
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
                      ],
                    ),
                  ),
                  onPressed: () {
                    _authBloc.add(SignUpRequest('onurural58@gmail.com', 'oNuR1905!'));
                  })),
        );
      }),
    );
  }
}

// BlocProvider(
//         create: (_) => _placeBloc,
//         child: BlocConsumer<PlaceBloc, PlaceState>(
//           listener: (context, state) {},
//           builder: (context, state) {
//             if (state is PlaceLoadedState) {
//                 return PlaceSmallCard(state.model[index], globalId);
//             }
//             if (state is PlaceLoadingState) {
//                 return  const CircularProgressIndicator();
//             }
//             if (state is PlaceErrorState) {
//               return const Text('Error on display the widget');
//             }
//             else {
//               return Text('Initial State ${state.toString()}');
//             }
//           }),
//         );