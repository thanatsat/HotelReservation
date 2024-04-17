import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test/pages/root_app.dart';
import 'package:test/screens/logout.dart';
import 'package:test/screens/signin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: 'AIzaSyDRILTNHIbc3VBMMN_i629lMnl1RBYvOSg',
    appId: '1:696276607475:web:e0fc68ae36307333ffb286',
    messagingSenderId: '696276607475',
    projectId: 'rorich-f15d5',
    authDomain: 'rorich-f15d5.firebaseapp.com',
    storageBucket: 'rorich-f15d5.appspot.com',
    measurementId: 'G-2WP4KNTD0S',
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SignInScreen(),
      routes: {
        '/root': (context) => RootApp(),
        '/logout': (context) => Logout(),
      },
    );
  }
}
