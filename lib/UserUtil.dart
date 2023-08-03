import 'dart:convert';

import 'package:flutter_social_media_app/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserUtil{

  static final UserUtil instance = UserUtil._internal();
  factory UserUtil(){
    return instance;
  }
  UserUtil._internal();


  saveUserList(List<User> userList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userListJson = jsonEncode(userList);
    prefs.setString('user_list', userListJson);
  }

 Future<List<User>?> getUserList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userListJson = prefs.getString('user_list');
    if (userListJson != null) {
      List<dynamic> userList = jsonDecode(userListJson);
      List<User> users = userList.map((i) => User.fromJson(i)).toList();

      return users;
    }
    return null;
  }




}