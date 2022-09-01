import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecommerce/dashboard_screen.dart';
import 'package:flutter_ecommerce/model/user_info.dart';
import 'package:flutter_ecommerce/service/authorization.dart';
import 'package:flutter_ecommerce/signup_screen.dart';
import 'package:flutter_ecommerce/utils.dart';
import 'package:flutter_ecommerce/verify_otp_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'model/login_response.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool saving = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));
    return Scaffold(
        body: ModalProgressHUD(
            inAsyncCall: saving,
            child: Container(
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
                      child: Form(
                        key: formKey,
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
                                      hintStyle: TextStyle(
                                          fontSize: 15, color: Colors.grey),
                                    ),
                                    validator: MultiValidator([
                                      RequiredValidator(errorText: "Required"),
                                    ])),
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
                                    validator: MultiValidator([
                                      RequiredValidator(errorText: "Required"),
                                    ])),
                                SizedBox(height: 36),
                                MaterialButton(
                                  onPressed: () {
                                    login(
                                        emailController.text.toString().trim(),
                                        passwordController.text
                                            .toString()
                                            .trim());
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
                                            moveToSignUpScreen();
                                          },
                                          child: Text("Sign Up",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontWeight.w500))),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ))
              ]),
            )));
  }

  void login(String email, String password) async {
    if (formKey.currentState!.validate()) {
      showProgress();
      LoginResponse? loginResponse =
          await RemoteService().login(email, password);
      hideProgress();
      if (loginResponse != null) {
        if (loginResponse.isSuccess) {
          var userdata = json.encode(loginResponse.info);
          if (loginResponse.isVerified!) {
            Utils.saveLoginData(userdata);
            moveToDashboardScreen();
          }else{
            moveToVerifyOtpScreen(loginResponse.user_id!);
          }
        } else {
          if (!mounted) return;
          Utils.handleUnauthorized(context, loginResponse.Message);
        }
      }
    }
  }

  void showProgress() {
    setState(() {
      saving = true;
    });
  }

  void hideProgress() {
    setState(() {
      saving = false;
    });
  }

  void moveToSignUpScreen() {
    /* Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => SignUpScreen(),
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        transitionDuration: Duration(milliseconds: 200),
      ),
    );*/
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  void moveToDashboardScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardScreen()),
    );
  }

  void moveToVerifyOtpScreen(int userId) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => VerifyOTP(userId: userId, isFromRegister: 1)),
    );
  }
}
