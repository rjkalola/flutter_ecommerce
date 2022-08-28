import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecommerce/login_screen.dart';
import 'package:flutter_ecommerce/signup_screen.dart';
import 'package:flutter_ecommerce/splash_screen.dart';
import 'package:flutter_ecommerce/verify_otp_screen.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Ecommerce App",
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home:  SplashScreen(),
    );
  }
}
