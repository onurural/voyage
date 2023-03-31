
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyage/bloc/place/place.bloc.dart';
import 'package:voyage/repository/place.repository.dart';
import 'package:voyage/views/home-view/HomePage.dart';


void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  WidgetsFlutterBinding.ensureInitialized();
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
    return  const MaterialApp(
      home: HomePage(),
    );
  }
}

