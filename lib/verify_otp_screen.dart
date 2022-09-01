import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecommerce/dashboard_screen.dart';
import 'package:flutter_ecommerce/model/base_response.dart';
import 'package:flutter_ecommerce/service/authorization.dart';
import 'package:flutter_ecommerce/utils.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'model/login_response.dart';
import 'model/user_info.dart';

class VerifyOTP extends StatefulWidget {
  VerifyOTP({Key? key, required this.userId, required this.isFromRegister})
      : super(key: key);
  int userId = 0, isFromRegister = 0;

  @override
  VerifyOTPState createState() => VerifyOTPState();
}

class VerifyOTPState extends State<VerifyOTP> {
  bool saving = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController box1 = TextEditingController();
  TextEditingController box2 = TextEditingController();
  TextEditingController box3 = TextEditingController();
  TextEditingController box4 = TextEditingController();

  @override
  void initState() {
    print("UserId:"+widget.userId.toString());
    super.initState();
  }

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
                                  child: Text("Enter a Verification Code",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 23,
                                      )),
                                ),
                                SizedBox(height: 4),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                  child: Center(
                                      child: Text(
                                          "Please enter a 4 digit verification code which you just received in your email or mobile number.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black26,
                                            fontSize: 14,
                                          ))),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 54,
                                      height: 54,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black38),
                                          borderRadius:
                                              BorderRadius.circular(45)),
                                      child: TextFormField(
                                        controller: box1,
                                        textAlign: TextAlign.center,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        maxLength: 1,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        inputFormatters: <TextInputFormatter>[
                                          // for below version 2 use this
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]'))
                                        ],
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                        decoration: InputDecoration(
                                          counterText: '',
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Container(
                                      width: 54,
                                      height: 54,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black38),
                                          borderRadius:
                                              BorderRadius.circular(45)),
                                      child: TextFormField(
                                        controller: box2,
                                        textAlign: TextAlign.center,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        maxLength: 1,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        inputFormatters: <TextInputFormatter>[
                                          // for below version 2 use this
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]'))
                                        ],
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                        decoration: InputDecoration(
                                          counterText: '',
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Container(
                                      width: 54,
                                      height: 54,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black38),
                                          borderRadius:
                                              BorderRadius.circular(45)),
                                      child: TextFormField(
                                        controller: box3,
                                        textAlign: TextAlign.center,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        maxLength: 1,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        inputFormatters: <TextInputFormatter>[
                                          // for below version 2 use this
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]'))
                                        ],
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                        decoration: InputDecoration(
                                          counterText: '',
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Container(
                                      width: 54,
                                      height: 54,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black38),
                                          borderRadius:
                                              BorderRadius.circular(45)),
                                      child: TextFormField(
                                        controller: box4,
                                        textAlign: TextAlign.center,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        maxLength: 1,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.done,
                                        inputFormatters: <TextInputFormatter>[
                                          // for below version 2 use this
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]'))
                                        ],
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                        decoration: InputDecoration(
                                          counterText: '',
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 34),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                  child: MaterialButton(
                                    onPressed: () {
                                      if (box1.text.toString().isNotEmpty &&
                                          box2.text.toString().isNotEmpty &&
                                          box3.text.toString().isNotEmpty &&
                                          box4.text.toString().isNotEmpty) {
                                        verifyOTP(box1.text.toString() +
                                            box2.text.toString() +
                                            box3.text.toString() +
                                            box4.text.toString());
                                      } else {
                                        Utils.showToastShort(
                                            context, "Enter OTP");
                                      }
                                    },
                                    color: Colors.lightGreen,
                                    elevation: 0,
                                    height: 42,
                                    splashColor: Colors.white.withAlpha(30),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Text("Submit",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        )),
                                  ),
                                ),
                                SizedBox(height: 26),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Don't get the code?",
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 15,
                                        )),
                                    Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: GestureDetector(
                                          onTap: () {
                                            resendOTP();
                                          },
                                          child: Text("Resend Code",
                                              style: TextStyle(
                                                  color: Colors.lightGreen,
                                                  fontSize: 15,
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

  void verifyOTP(String code) async {
    if (formKey.currentState!.validate()) {
      showProgress();
      LoginResponse? loginResponse = await RemoteService()
          .verifyOTP(widget.userId, code, widget.isFromRegister);
      hideProgress();
      if (loginResponse != null) {
        print(loginResponse.toJson().toString());
        if (loginResponse.isSuccess) {
          var userdata = json.encode(loginResponse.info);
          Map<String, dynamic> userMap = jsonDecode(userdata);
          Utils.userInfo = UserInfo.fromJson(userMap);
          Utils.saveLoginData(userdata);
          moveToDashboardScreen();
        } else {
          if (!mounted) return;
          Utils.handleUnauthorized(context, loginResponse.Message);
        }
      }
    }
  }

  void resendOTP() async {
    showProgress();
    CommonResponse? commonResponse =
        await RemoteService().resendOTP(widget.userId);
    hideProgress();
    if (commonResponse != null) {
      print(commonResponse.toJson().toString());
      if (commonResponse.isSuccess) {
      } else {
        if (!mounted) return;
        Utils.handleUnauthorized(context, commonResponse.Message);
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

  void moveToDashboardScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardScreen()),
    );
  }
}
