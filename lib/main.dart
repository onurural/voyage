import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:voyage/views/auth.view.dart';
import 'package:voyage/views/main-connector.dart';
import 'package:firebase_performance/firebase_performance.dart';

import 'bloc/user/user.bloc.dart';
import 'bloc/user/user.event.dart';
import 'data/auth.data.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final FirebasePerformance _performance = FirebasePerformance.instance;
  Trace performanceTrace = _performance.newTrace("performance test");
  Trace networkTrace=_performance.newTrace("network trace");
  performanceTrace.start();
  networkTrace.start();

  final authData = AuthData();
  final userId = authData.getCurrentUserId();

  runApp(MyApp(userId: userId));
}

class MyApp extends StatelessWidget {

  final String? userId;

  const MyApp({Key? key, this.userId}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          if (userId == null) {
            // No user is currently signed in, show the AuthScreen.
            return const AuthScreen();
          } else {
            // A user is signed in, initialize the UserBloc and fetch user details.
            final userBloc = UserBloc()..add(GetUserCredential(userId!));
            return BlocProvider(
              create: (context) => userBloc,
              child: const MainConnector(), // Replace with your main page widget
            );
          }
        },
      ),
    );
  }
}
