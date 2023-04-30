import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';




class SignupWidget extends StatefulWidget {
  final Function(double) onNavigate;

  SignupWidget(this.onNavigate, {super.key});

  @override
  _SignupWidgetState createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _onLoginButtonPressed() {
    widget.onNavigate(1);
  }

  void _onSignupButtonPressed() {

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sign Up', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            SizedBox(height: 40),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email'),
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
                  SizedBox(height: 20),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
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
            SizedBox(height: 20),
            TextButton(
              onPressed: _onLoginButtonPressed,
              child: Text('Already have an account? Log In'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onSignupButtonPressed,
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}