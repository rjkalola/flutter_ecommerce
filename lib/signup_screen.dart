import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecommerce/dashboard_screen.dart';
import 'package:flutter_ecommerce/model/sign_up_response.dart';
import 'package:flutter_ecommerce/service/authorization.dart';
import 'package:flutter_ecommerce/utils.dart';
import 'package:flutter_ecommerce/verify_otp_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'model/login_response.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUpScreen> {
  bool saving = false;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
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
          child: Stack(alignment: Alignment.topCenter, children: [
            Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 120),
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
                                    controller: firstName,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      hintText: 'First Name',
                                      labelText: 'First Name',
                                      labelStyle: TextStyle(color: Colors.grey),
                                      hintStyle: TextStyle(
                                          fontSize: 15, color: Colors.grey),
                                    ),
                                    validator: MultiValidator([
                                      RequiredValidator(errorText: "Required"),
                                    ])),
                                SizedBox(height: 12),
                                TextFormField(
                                    controller: lastName,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      hintText: 'Last Name',
                                      labelText: 'Last Name',
                                      labelStyle: TextStyle(color: Colors.grey),
                                      hintStyle: TextStyle(
                                          fontSize: 15, color: Colors.grey),
                                    ),
                                    validator: MultiValidator([
                                      RequiredValidator(errorText: "Required"),
                                    ])),
                                SizedBox(height: 12),
                                TextFormField(
                                    controller: email,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      hintText: 'Email',
                                      labelText: 'Email',
                                      labelStyle: TextStyle(color: Colors.grey),
                                      hintStyle: TextStyle(
                                          fontSize: 15, color: Colors.grey),
                                    ),
                                    validator: MultiValidator([
                                      RequiredValidator(errorText: "Required"),
                                      EmailValidator(
                                          errorText: "Enter valid email")
                                    ])),
                                SizedBox(height: 12),
                                TextFormField(
                                    controller: password,
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
                                    validator: MultiValidator([
                                      RequiredValidator(errorText: "Required"),
                                    ])),
                                SizedBox(height: 12),
                                TextFormField(
                                    controller: phoneNumber,
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
                                    validator: MultiValidator([
                                      RequiredValidator(errorText: "Required"),
                                    ])),
                                SizedBox(height: 36),
                                MaterialButton(
                                  onPressed: () {
                                    signUp(
                                        firstName.text.toString().trim(),
                                        lastName.text.toString().trim(),
                                        phoneNumber.text.toString().trim(),
                                        email.text.toString().trim(),
                                        password.text.toString().trim());
                                  },
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
      ),
    );
  }

  void signUp(String firstName, String lastName, String phoneNumber,
      String email, String password) async {
    if (formKey.currentState!.validate()) {
      showProgress();
      SignUpResponse? signUpResponse = await RemoteService()
          .signUp(firstName, lastName, phoneNumber, email, password);
      hideProgress();
      if (signUpResponse != null) {
        print(signUpResponse.toJson().toString());
        if (signUpResponse.isSuccess) {
          moveToVerifyOtpScreen(signUpResponse.userId!);
        } else {
          if (!mounted) return;
          Utils.handleUnauthorized(context, signUpResponse.Message);
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

  void moveToVerifyOtpScreen(int userId) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => VerifyOTP(userId: userId, isFromRegister: 1)),
    );
  }
}
