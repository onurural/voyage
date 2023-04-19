import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class TermsOfServicePage extends StatefulWidget {
  @override
  _TermsOfServicePageState createState() => _TermsOfServicePageState();
}

class _TermsOfServicePageState extends State<TermsOfServicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            Center(
              child: TypewriterAnimatedTextKit(
                text: ['Voyage Terms of Service'],
                textStyle: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                speed: Duration(milliseconds: 200),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Welcome to Voyage! These Terms of Service ("Terms") govern your use of the Voyage application, website, and any other services provided by Voyage (collectively, the "Services").'
                  '\n\n1. Acceptance of Terms\n\n'
                  'By accessing or using our Services, you agree to be bound by these Terms. If you do not agree to these Terms, you must not access or use the Services.'
                  '\n\n2. Changes to Terms\n\n'
                  'We may modify these Terms at any time, and such modifications will be effective immediately upon posting the modified Terms on our website or within the application. Your continued use of the Services following the posting of modified Terms constitutes your acceptance of those modified Terms.'
                  '\n\n3. Eligibility\n\n'
                  'By using our Services, you represent and warrant that you are at least 13 years of age and have the legal capacity to enter into these Terms.'
                  '\n\n4. User Content\n\n'
                  'When you submit, post, or otherwise provide content through the Services, you grant us a non-exclusive, sublicensable, irrevocable, royalty-free license to use, display, and distribute that content in connection with the Services.'
                  '\n\n5. Termination\n\n'
                  'We reserve the right to terminate your access to and use of the Services at any time, for any reason, without notice or liability.'
                  '\n\n6. Disclaimer\n\n'
                  'The Services are provided "AS IS" and "AS AVAILABLE." We disclaim all warranties of any kind, whether express or implied, including but not limited to the implied warranties of merchantability, fitness for a particular purpose, and non-infringement.'
                  '\n\n7. Limitation of Liability\n\n'
                  'In no event will we be liable for any direct, indirect, incidental, special, consequential, or punitive damages arising out of or in connection with your use of the Services or these Terms.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
