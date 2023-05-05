import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color.fromRGBO(80, 120, 150, 1),
                Colors.blueGrey,


                Colors.transparent,
              ],
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/Images/Logo.png',
                    width: 200,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ClipPath(
                      clipper: _BackgroundShapeClipper(),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: PageView(
                          controller: _pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            SignupWidget((index) => _navigateTo(index.toInt())),
                            LoginWidget((index) => _navigateTo(index.toInt())),
                            ForgotPasswordWidget((index) => _navigateTo(index.toInt())),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class _BackgroundShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.25, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
