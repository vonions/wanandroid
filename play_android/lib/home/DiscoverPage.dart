import 'dart:math';

import 'package:banner/banner.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:play_android/Util.dart';
import 'package:play_android/bean/home_banner_result_entity.dart';
import 'package:play_android/bean/home_hot_net_result_entity.dart';

import 'DetailPage.dart';

class DiscoverPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DiscoverPage();
  }
}

class _DiscoverPage extends State<DiscoverPage> {
  HomeBannerResultEntity bannerResult;
  HomeHotNetResultEntity hotNet;

  @override
  Widget build(BuildContext context) {
    if (bannerResult == null) {
      _getBanner();
      return Scaffold(
        body: Container(
          child: Util.LoadingWidget(),
          alignment: Alignment.center,
        ),
      );
    }
    if (hotNet == null) {
      _getHotNetUrl();
      return Scaffold(
        body: Container(
          child: Util.LoadingWidget(),
          alignment: Alignment.center,
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Util.bannerView(bannerResult, context),
          Container(
            margin: EdgeInsets.all(15),
            alignment: Alignment.centerLeft,
            child: Text(
              "常用网站",
              style: TextStyle(fontSize: 20),
            ),
          ),
          //TAG
          Container(

            child: Tags(
              itemCount: hotNet.data.length,
              itemBuilder: (int index) {
                return Tooltip(
                  message: hotNet.data[index].name,
                  child: ItemTags(
                    index: index,
                    active: false,
                    title: hotNet.data[index].name,
                    onPressed: (net) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DetailPage(
                            hotNet.data[index].name, hotNet.data[index].link);
                      }));
                    },
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }

  //banner
  @override
  _getBanner() async {
    var respon = await new Dio().get("https://www.wanandroid.com/banner/json");

    bannerResult = HomeBannerResultEntity().fromJson(respon.data);
    setState(() {});
  }

  //hot net
  _getHotNetUrl() async {
    var respon = await new Dio().get("https://www.wanandroid.com/friend/json");
    hotNet = HomeHotNetResultEntity().fromJson(respon.data);
    setState(() {});
  }
}
