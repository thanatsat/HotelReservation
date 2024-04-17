// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:test/screens/signin_screen.dart';
import 'package:flutter/material.dart';

class Logout extends StatelessWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 1.0, top: 10.0, bottom: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.only(left: 1.0),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Icon(Icons.menu, color: Colors.black),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      backgroundColor: Color(0xFF0000EB),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Are you sure?',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            ElevatedButton(
              child: Text("Logout"),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  print("Signed Out");
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  );
                }).catchError((error) {
                  print("Sign out failed: $error");
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
