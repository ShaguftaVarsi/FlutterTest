import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/main');  // Navigate to MainScreen
    });

    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/app_splash.jpg'), // Example image
      ),
    );
  }
}
