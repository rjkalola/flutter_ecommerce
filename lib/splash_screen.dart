import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecommerce/dashboard_screen.dart';
import 'package:flutter_ecommerce/model/user_info.dart';
import 'package:flutter_ecommerce/signup_screen.dart';
import 'package:flutter_ecommerce/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SharedPreferences.getInstance().then((prefValue) => {
          setState(() {
            var userdata = prefValue.getString(Utils.KEY_LOGIN_DATA) ?? "";
            Future.delayed(const Duration(seconds: 4), () {
              if (userdata.isEmpty) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              } else {
                Map<String, dynamic> userMap = jsonDecode(userdata);
                Utils.userInfo = UserInfo.fromJson(userMap);
                print("username:${Utils.userInfo?.name}");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DashboardScreen()),
                );
              }
            });
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: SvgPicture.asset(
        'assets/images/img_app_logo.svg',
        height: 190,
        width: 190,
      )),
    );
  }
}
