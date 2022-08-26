import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecommerce/signup_screen.dart';
import 'package:flutter_ecommerce/utils.dart';
import 'package:flutter_svg/svg.dart';
import 'signup_screen.dart';
import 'package:http/http.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email, String password) async {
    print("${Utils.appUrl}kk-login");
    try {
      Response response = await post(Uri.parse("${Utils.appUrl}kk-login"),
          body: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        print("Login Successfully");
      } else {
        print("Login Failed");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/img_login_bg.png',
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
              height: 120,
              width: 120,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SvgPicture.asset(
                  'assets/images/img_app_logo.svg',
                ),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(22),
                          topRight: Radius.circular(22))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child: ListView(
                      children: <Widget>[
                        SizedBox(height: 4),
                        Center(
                          child: Text("Welcome back",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 25,
                              )),
                        ),
                        SizedBox(height: 4),
                        Center(
                            child: Text("Login to your account",
                                style: TextStyle(
                                  color: Colors.black26,
                                  fontSize: 14,
                                ))),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: 'Email or Mobile Number',
                            labelText: 'Email or Mobile Number',
                            labelStyle: TextStyle(color: Colors.grey),
                            hintStyle:
                                TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                        ),
                        SizedBox(height: 14),
                        TextFormField(
                          controller: passwordController,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.grey),
                            hintStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(height: 36),
                        MaterialButton(
                          onPressed: () {
                            login(emailController.text.toString().trim(),
                                passwordController.text.toString().trim());
                          },
                          color: Colors.lightGreen,
                          elevation: 0,
                          height: 42,
                          splashColor: Colors.white.withAlpha(30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Text("Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              )),
                        ),
                        SizedBox(height: 32),
                        GestureDetector(
                          onTap: () {},
                          child: Center(
                              child: Text(
                            "Forgot your password?",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          )),
                        ),
                        SizedBox(height: 26),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?",
                                style: TextStyle(
                                  color: Colors.black26,
                                  fontSize: 15,
                                )),
                            Padding(
                              padding: EdgeInsets.all(4.0),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUpScreen()),
                                    );
                                  },
                                  child: Text("Sign Up",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500))),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ))
        ]),
      ),
    );
  }
}
