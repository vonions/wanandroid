import 'dart:math';

import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:play_android/NetUtil.dart';
import 'package:play_android/Util.dart';
import 'package:play_android/bean/login_result_entity.dart';
import 'package:play_android/login/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../CollectionListPage.dart';
import '../DailyAskPage.dart';
import '../InterviewAboutPage.dart';
import '../DataServe.dart';
import '../EventBusUtil.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MinePage();
  }
}

class _MinePage extends State<MinePage> {
  String name = "未登录";
  int jifen = -1;
  String rank;

  @override
  Widget build(BuildContext context) {
    print("swtlog====build");
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      child: Column(
        children: [
          //顶部
          _TopWidget(),
          //收藏
          Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.topLeft,
            child: Card(
                child: Container(
                  padding: EdgeInsets.only(
                      left: 5, top: 20, bottom: 20, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child:  Text("收藏文章", style: TextStyle(fontSize: 18)),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return CollectionListPage();
                          }));
                        },
                      ),

                      Text("分享文章", style: TextStyle(fontSize: 18)),
                      Text("收藏网址", style: TextStyle(fontSize: 18)),
                      Text("分享项目", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                )),
          ),
          //快捷入口
          _Convenient()
        ],
      ),
    );
  }

  //便捷入口
  Widget _Convenient() {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 15, bottom: 15),
              child: Text("便捷入口", style: TextStyle(fontSize: 18),)

          ),

          Row(
            children: [
              GestureDetector(
                child:
                Container(
                  //面试指南
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 15, bottom: 15),
                  child: Image.network(
                      "https://www.wanandroid.com/blogimgs/b1bd944a-4a9e-4722-81c5-079676422c5e.jpg",
                      width: 160),
                ),
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return InterviewAboutPage();
                  }));
                },

              ),
              GestureDetector(
                child: Container(
                  //每日一问
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 5, bottom: 15),
                  child: Image.network(
                      "https://www.wanandroid.com/blogimgs/9d04f303-fc08-4582-b50d-4dedb1f566c9.jpg",
                      width: 160),
                ),
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DailyAskPage();
                  }));
                },
              )
              ,
            ],
          )

        ],
      ),
    );
  }

  _TopWidget() {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 150,
            color: Colors.blue,
          ),
          Container(
            margin: EdgeInsets.only(left: 15, top: 25),
            child: _Touxiang(),
          ),
          Positioned(
            right: 16,
            top: 40,
            child: Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
          Positioned(
            left: 80,
            bottom: 15,
            child: Container(
              alignment: Alignment.bottomLeft,
              child: _Jifen(),
            ),
          )
        ],
      ),
    );
  }

  Widget _Jifen() {
    return Container(
      child: new Row(
        children: [
          Text(
            "个人积分:$jifen   ",
            style: TextStyle(color: Colors.white),
          ),
          Text("个人排名:$rank", style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  //头像
  _Touxiang() {
    _getUserInfo();

    return GestureDetector(
      child: Row(
        children: [
          Align(
            child: CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(
                  "https://himg.bdimg.com/sys/portraitn/item/2ab8c7fad6d5c8cbc9a230303533f30d"),
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              )),
        ],
      ),
      onTap: () {
        var login = _isLogin();

        login.then((value) =>
        {
//              if (value)
//                {
//                  //
//                  Toast.show("已经登录", context)
//                }
//              else
//                {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return LoginPage();
          }))
//                }
        });

//        _getUserInfo();
      },
    );
  }

  // 获取用户个人信息
  _getUserInfo() async {
    var respon =
    NetUtil.get("https://www.wanandroid.com/lg/coin/userinfo/json");

    print(respon);
  }

  _getJifen() async {
    if (jifen == -1) {
      print("获取积分star");
      var data = await DataServe().getCoin();
      jifen = data.data.coinCount;
      rank = data.data.rank;
      setState(() {});
      print("获取积分end");
    }
  }

  @override
  void initState() {
    super.initState();
    _getJifen();
    _isName();
    print("swtlog====initState");

    EventBusUtil.getInstance().on<LoginResultEntity>().listen((event) {
      print("eventbus" + event.data.toString());
      name = event.data.nickname;
      setState(() {});
    });
  }

  Future<bool> _isLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var res = sharedPreferences.getBool("islogin");
    print("swtinof==login?$res");
    if (res == null) {
      return false;
    }
    return res;
  }

  _isName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var res = sharedPreferences.getString("name");
    print("swtinof==login?$res");
    if (res == null) {
      return "";
    }
    name = res;
    setState(() {});
  }
}
