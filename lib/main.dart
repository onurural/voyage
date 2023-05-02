import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:voyage/views/auth.view.dart';
import 'package:voyage/views/log-in.view.dart';
//import 'package:voyage/views/main-connector.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

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
    return const MaterialApp(
      home: AuthScreen()
      );
    
  }
}
