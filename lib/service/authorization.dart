import 'dart:convert';

import 'package:flutter_ecommerce/model/dashboard_response.dart';
import 'package:flutter_ecommerce/model/sign_up_response.dart';
import 'package:http/http.dart';
import '../model/base_response.dart';
import '../model/login_response.dart';
import '../utils.dart';

class RemoteService {
  Future<LoginResponse?> login(String email, String password) async {
    Response response = await post(Uri.parse("${Utils.appUrl}kk-login"),
        body: {'email': email, 'password': password});
    if (response.statusCode == 200) {
      var data = response.body;
      return loginResponseFromJson(data);
    }
  }

  Future<SignUpResponse?> signUp(String firstName, String lastName,
      String phoneNumber, String email, String password) async {
    Response response =
        await post(Uri.parse("${Utils.appUrl}kk-ecomreg"), body: {
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'email': email,
      'password': password
    });
    if (response.statusCode == 200) {
      var data = response.body;
      return signUpResponseFromJson(data);
    }
  }

  Future<LoginResponse?> verifyOTP(
      int userId, String code, int isFromRegister) async {
    print("userId:"+userId.toString());
    print("code:"+code);
    print("isFromRegister:"+isFromRegister.toString());
    Response response = await post(Uri.parse("${Utils.appUrl}verify-code"),
        body: {
          'user_id': userId.toString(),
          'code': code,
          'is_from_register': isFromRegister.toString()
        });
    if (response.statusCode == 200) {
      var data = response.body;
      return loginResponseFromJson(data);
    }
  }

  Future<CommonResponse?> resendOTP(int userId) async {
    Response response = await post(Uri.parse("${Utils.appUrl}resend-code"),
        body: {'user_id': userId.toString()});
    if (response.statusCode == 200) {
      var data = response.body;
      return baseResponseFromJson(data);
    }
  }

  Future<DashboardResponse?> getDashboardData(int limit,int offset) async {
    Response response = await post(Uri.parse("${Utils.appUrl}dashboard"),
        body: {'limit': limit.toString(),'offset': offset.toString()});
    if (response.statusCode == 200) {
      var data = response.body;
      return dashboardResponseFromJson(data);
    }
  }
}
