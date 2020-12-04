import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:play_android/NetUtil.dart';
import 'package:play_android/bean/login_result_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import '../EventBusUtil.dart';
import '../EventbusEvent.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  //用户名
  String user = "";

  //密码
  String psw = "";

  LoginResultEntity login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("账号登录"),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              child: Image.network(
                  "https://www.wanandroid.com/resources/image/pc/logo.png")),
          Container(
            child: Column(
              children: [
                _Account("请输入用户名", "用户名", 1),
                _Account("请输入密码", "密码", 2),
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.all(25),
                    width: 120,
                    height: 40,
                    decoration: new BoxDecoration(
                      border: new Border.all(color:Colors.blue, width: 0.5), // 边色与边宽度
                      color: Colors.blue, // 底色
                      //        shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
                      shape: BoxShape.rectangle, // 默认值也是矩形
                      borderRadius: new BorderRadius.circular((20.0)), // 圆角度
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "登录",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () {
                    if (user == "") {
                      Toast.show("请输入用户名", context);
                      return;
                    }
                    if (psw == "") {
                      Toast.show("请输入密码", context);
                      return;
                    }
                    _login(user, psw);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _Account(String hint, label, int index) {
    return Container(
      margin: EdgeInsets.only(left: 15,right: 15,top: 15),
      child: TextField(
        decoration: InputDecoration(hintText: hint, labelText: label),
        onChanged: (String text) {
          if (index == 1) {
            user = text;
          } else {
            psw = text;
          }
        },
      ),
    );
  }

  _login(String name, psw) async {
    FormData json = FormData.fromMap({"username": name, "password": psw});

    var respon = await NetUtil
        .post("https://www.wanandroid.com/user/login",json);

    login = LoginResultEntity().fromJson(respon);
    if (login.errorCode != 0) {
      //登录失败
      Toast.show(login.errorMsg, context);
    } else {
      //登录成功
      Toast.show("登录成功", context);
      _saveUserInfo(true);
      _saveUserName(login.data.nickname);
      EventBusUtil.getInstance().fire(login);
      Navigator.pop(context);
    }
  }

  _saveUserInfo(bool login) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("islogin", login);
  }
  _saveUserName(String name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("name", name);
  }
}
