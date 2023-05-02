import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';




class ForgotPasswordWidget extends StatefulWidget {
  final Function(double) onNavigate;

  ForgotPasswordWidget(this.onNavigate);

  @override
  _ForgotPasswordWidgetState createState() => _ForgotPasswordWidgetState();
}

class _ForgotPasswordWidgetState extends State<ForgotPasswordWidget> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';

  void _onLoginButtonPressed() {
   widget. onNavigate(1);
  }

  void _onResetPasswordButtonPressed() {

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Forgot Password', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
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
                  ],
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: _onLoginButtonPressed,
                child: Text('Back to Login'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _onResetPasswordButtonPressed,
                child: Text('Reset Password'),
              ),
            ],
          ),
        ),
    );
  }
}