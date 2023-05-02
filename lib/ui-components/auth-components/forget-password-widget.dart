import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';


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
    widget.onNavigate(1);
  }

  void _onResetPasswordButtonPressed() {
    if (_formKey.currentState!.validate()) {
      // Add code to handle resetting password
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Forgot Password', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
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
            ElevatedButton(
              onPressed: _onResetPasswordButtonPressed,
              child: const Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
