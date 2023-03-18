
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voyage/Auth/ForgetPasswordPage.dart';
import 'package:voyage/Auth/SignUpScreen.dart';
import 'package:voyage/Components/DrawerWidget.dart';
import 'package:voyage/Components/NavBar.dart';

import 'package:voyage/ScreensContainer/HomeCon.dart';



import 'Auth/LogInScreen.dart';
import 'Components/DrawerItem.dart';
import 'Components/DrawerItems.dart';
import 'OnBoarding/OnBoardingScreen.dart';
void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home:ForgetPasswordPage()



    );
  }

}

