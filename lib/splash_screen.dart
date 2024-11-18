import 'dart:async';
import 'package:flutter/material.dart';
import 'login_page.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });

    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Text(
          'Welcome to ChatWave',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
