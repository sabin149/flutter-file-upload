import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import '/model/user.dart';
import '/response/user_resp.dart';

class HttpConnectUser {
  // String baseurl = "http://192.168.1.68:4000/api/v1/";
  String baseurl = "http://10.0.2.2:4000/api/v1/";
  static String token = '';

  // static variable
  
  ///ek thau ma matra memory ma bancha
  /// static keyword is not related to object
  /// it can access by class name -> HttpConnectUser.token outside the class

  //sending data to the server--- creating user
  Future<bool> registerPost(User user) async {
    Map<String, dynamic> userMap = {
      "fname": user.firstname,
      "lname": user.lastname,
      "username": user.username, 
      "password": user.password,
    };

      final response =
        await post(Uri.parse(baseurl + 'auth/register'), body: userMap);
    if (response.statusCode == 200) {
      var usrRes = ResponseUser.fromJson(jsonDecode(response.body));
      return usrRes.success! ;
    } else {
      return false; 
    }
  }

// http://www.facebook.com/register/......->String
// uri- uri is a class in which it separates the string url into various parts and saves different informations into the attributes. like 
//which is protocol-> http
//which is path -> register, 
//which is domain/hostname ->www.facebook.com ,
// which is parameter->....
// for doing this a URi.parse method is given that helps to create the uri object 

// jsonDecode()-> converts the response body(json string) into a json object(json map) 

  //sending data to the server- login as user
  Future<bool> loginPosts(String username, String password) async {
    Map<String, dynamic> loginStudent = {
      'username': username,
      'password': password
    };
    try {
      final response = await post(
          Uri.parse(
            baseurl + "auth/login",
          ),
          body: loginStudent);

      //json serializing inline
      final jsonData = jsonDecode(response.body) as Map;
      // bool val = jsonData['success'];
      // print(jsonData['token']);
      token = jsonData['token'];
//merotoken = jsonData['token'];

      if (token.isNotEmpty) {
        return true; 
      }

//  if (jsonData['success']) { 
//         return true;
//       }

    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }
}


