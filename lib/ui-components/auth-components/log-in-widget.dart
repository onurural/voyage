import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';


class LoginWidget extends StatefulWidget {
  final Function(double) onNavigate;

  LoginWidget(this.onNavigate);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _onSignUpButtonPressed() {
    widget.onNavigate(0);
  }

  void _onForgotPasswordButtonPressed() {
  widget.onNavigate(2);
  }

  void _onLoginButtonPressed() {
    if (_formKey.currentState!.validate()) {
      // Perform login action
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Login', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _onSignUpButtonPressed,
                  child: Text('Sign Up'),
                ),
                TextButton(
                  onPressed: _onForgotPasswordButtonPressed,
                  child: Text('Forgot Password?'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onLoginButtonPressed,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}