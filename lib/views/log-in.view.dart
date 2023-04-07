import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/views/home-container.dart';
import 'package:voyage/views/forget-password.view.dart';
import 'package:voyage/views/sign-up.view.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  var activeOrDoneColor = Colors.white;
  var hintTextColor = const Color.fromRGBO(117, 117, 117, 100);
  var borderColor = const Color.fromRGBO(117, 117, 117, 100);
  var iconColor = const Color.fromRGBO(117, 117, 117, 100);
  bool _obscureText = true;
  final _passwordController = TextEditingController();
  final List<FocusNode> _focusNodes = [
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


    var orangeOpenSans = GoogleFonts.openSans(
                        fontSize: 20,
                        color: const Color.fromRGBO(248, 132, 20, 100),
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w700);
    return Scaffold(
      body: Center(
        child: Container(
          decoration: backgroundDecoration(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                logo(),
                loginForm(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                  child: Text(
                    'Sign In With',
                    style: openSans,
                  ),
                ),
                socialLoginButtons(),
                Text(
                  'Not a member yet?',
                  style: openSans,
                ),
                MaterialButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()),
                    )
                  },
                  child: Text(
                    'Register',
                    style: orangeOpenSans,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox logo() {
    return SizedBox(width: 300, child: Image.asset('assets/Images/Logo.png'));
  }

  BoxDecoration backgroundDecoration() {
    return const BoxDecoration(
        gradient: LinearGradient(
            colors: [Color.fromRGBO(37, 154, 180, 100), Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter));
  }

  Padding socialLoginButtons() {
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

  Padding loginForm() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: Form(
          child: Column(
        children: [
          emailInput(),
          passwordInput(),
          forgetPassword(),
          loginButton()
        ],
      )),
    );
  }

  TextStyle poppins(FontWeight weight) {
    return GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: weight,
                  letterSpacing: 1,
                  decoration: TextDecoration.none);
  }

  Material emailInput() {
    return Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextField(
                focusNode: _focusNodes[0],
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                style: poppins(FontWeight.w800),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.mail),
                  prefixIconColor: _focusNodes[0].hasFocus
                      ? const Color.fromRGBO(37, 150, 190, 100)
                      : Colors.white,
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: 'E-mail address',
                  hintStyle: poppins(FontWeight.w700),
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

  Material passwordInput() {
     return Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                focusNode: _focusNodes[1],
                keyboardType: TextInputType.visiblePassword,
                autofillHints: const [AutofillHints.password],
                style: poppins(FontWeight.w800),
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
                  hintStyle: poppins(FontWeight.w700),
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

  Padding forgetPassword() {
    return Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: Align(
              alignment: Alignment.topRight,
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ForgetPasswordPage()),
                  );
                },
                child: Text(
                  'Forgotten Password?',
                  style: GoogleFonts.openSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
            ),
          );
  }

  Padding loginButton() {
    return Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
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
                            'Log In',
                            style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 23,
                                    fontWeight: FontWeight.w800)),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Icon(
                              Icons.login_sharp,
                              color: Colors.white,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeCon()),
                      );
                    })),
          );
  }
}
