import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ui-components/auth-components/forget-password-widget.dart';
import '../ui-components/auth-components/log-in-widget.dart';
import '../ui-components/auth-components/sign-up-widget.dart';




class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateTo(int pageIndex) {
    _pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            SignupWidget( (index) => _navigateTo(index.toInt())),

            LoginWidget( (index) => _navigateTo(index.toInt())),
            ForgotPasswordWidget( ( index) => _navigateTo(index.toInt())),

          ],
        ),
      ),
    );
  }
}