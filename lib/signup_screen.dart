import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
        child: Stack(alignment: Alignment.topCenter, children: [
          Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 120),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(22),
                              topRight: Radius.circular(22))),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 26, 24, 0),
                        child: ListView(
                          children: <Widget>[
                            Center(
                              child: Text("Sign Up",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 24,
                                  )),
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: 'First Name',
                                labelText: 'First Name',
                                labelStyle: TextStyle(color: Colors.grey),
                                hintStyle:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                            ),
                            SizedBox(height: 12),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: 'Last Name',
                                labelText: 'Last Name',
                                labelStyle: TextStyle(color: Colors.grey),
                                hintStyle:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                            ),
                            SizedBox(height: 12),
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
                            SizedBox(height: 12),
                            TextFormField(
                              controller: passwordController,
                              textInputAction: TextInputAction.next,
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
                            SizedBox(height: 12),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                // for below version 2 use this
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'))
                              ],
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                hintText: 'Mobile Number',
                                labelText: 'Mobile Number',
                                labelStyle: TextStyle(color: Colors.grey),
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(height: 36),
                            MaterialButton(
                              onPressed: () {},
                              color: Colors.lightGreen,
                              elevation: 0,
                              height: 42,
                              splashColor: Colors.white.withAlpha(30),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text("Create Account",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ],
          ),
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
          )
        ]),
      ),
    );
  }
}
