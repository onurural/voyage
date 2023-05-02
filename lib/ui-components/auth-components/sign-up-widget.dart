import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/bloc/auth/auth.block.dart';
import 'package:voyage/bloc/auth/auth.event.dart';
import 'package:voyage/bloc/auth/auth.state.dart';
import 'package:voyage/data/auth.data.dart';
import 'package:voyage/views/main-connector.dart';




class SignupWidget extends StatefulWidget {
  final Function(double) onNavigate;

  const SignupWidget(this.onNavigate, {super.key});

  @override
  _SignupWidgetState createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {

  final AuthBloc _authBloc =  AuthBloc();
  final AuthData _authData = AuthData();
  
  String _email = '';
  String _password = '';

  final _emailController= TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  
  final _formKey = GlobalKey<FormState>();

  void _onLoginButtonPressed() {
    widget.onNavigate(1);
  }

  void _onSignupButtonPressed() {
    _authBloc.add(SignUpRequest(_emailController.text, _passwordController.text));
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
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'Email'),
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
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
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
            TextButton(
              onPressed: _onLoginButtonPressed,
              child: const Text('Already have an account? Log In'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onSignupButtonPressed,
              child: BlocProvider(
                create: (_) => _authBloc,
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
                          BlocConsumer<AuthBloc, AuthState>(
                            listener: (context, state) {
                          if (state is AuthSuccessState) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainConnector()),
                            );
                            var userId = _authData.getCurrentUserId();
                            _authBloc.add(SaveUserToMongoDB(_emailController.text, userId!, _userNameController.text));
                          } else if (state is AuthFailedState) {
                            // TODO REMOVE THIS
                              Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainConnector()),
                            );
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
                      _authBloc.add(SignUpRequest(_emailController.text, _passwordController.text));
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }



  Padding usernameInputField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Material(
        color: Colors.transparent,
        child: TextField(
          controller: _userNameController,
          keyboardType: TextInputType.name,
          autofillHints: const [AutofillHints.username],
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person),
            filled: true,
            fillColor: Colors.transparent,
            hintText: 'Username',
            hintStyle: GoogleFonts.poppins(
                textStyle: TextStyle(
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
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }

}