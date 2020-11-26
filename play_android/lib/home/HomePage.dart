import 'dart:math';

import 'package:banner/banner.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:play_android/bean/home_banner_result_entity.dart';
import 'package:play_android/bean/home_hot_net_result_entity.dart';
import 'package:play_android/bean/home_list_result_entity.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:play_android/Util.dart';

import 'DetailPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  int page = 0;
  List<HomeListResultDataData> list = null;

  HomeBannerResultEntity bannerResult;

  _onRefresh() async {
    await _loadData(0, true);
    _refreshController.refreshCompleted();
  }

  _onLoadMore() async {
    await _loadData(page + 1, false);
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    if (list == null || bannerResult == null) {
      if (list == null) {
        _loadData(0, true);
      } else if (bannerResult == null) {
        _getBanner();
      }

      return Scaffold(
          body: // 圆形进度条
              Container(
        alignment: Alignment.center,
        child: Util.LoadingWidget(),
      ));
    }
    return Scaffold(
        body: SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      footer: LinkFooter(),
      onRefresh: _onRefresh,
      onLoading: _onLoadMore,
      controller: _refreshController,
      child: _HomePageWidget(),
    ));
  }

  Widget _HomePageWidget() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Util.bannerView(bannerResult, context),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, i) {
            return Container(
              child: GestureDetector(
                child: _ItemCard(i),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DetailPage(list[i].title, list[i].link);
                  }));
                },
              ),
            );
          }, childCount: list.length),
        )
      ],
    );
  }

  Widget _ItemCard(i) {
    return Card(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 15, top: 15),
            child: Text(
              list[i].title,
              style: TextStyle(fontSize: 17, fontStyle: FontStyle.normal),
            ),
            alignment: Alignment.centerLeft,
          ),
          Container(
            margin: EdgeInsets.only(left: 15, top: 15, bottom: 15),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Text("作者:${list[i].shareUser}"),
                Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Text("时间:${list[i].niceShareDate}")),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _SmartRefresh() {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      footer: LinkFooter(),
      onRefresh: _onRefresh,
      onLoading: _onLoadMore,
      controller: _refreshController,
      child: _ListView(),
    );
  }

  Widget _ListView() {
    return ListView.builder(
      itemBuilder: (c, i) => GestureDetector(
        child: Card(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 15, top: 15),
                child: Text(
                  list[i].title,
                  style: TextStyle(fontSize: 17, fontStyle: FontStyle.normal),
                ),
                alignment: Alignment.centerLeft,
              ),
              Container(
                margin: EdgeInsets.only(left: 15, top: 15, bottom: 15),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text("作者:${list[i].shareUser}"),
                    Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Text("时间:${list[i].niceShareDate}")),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      itemCount: list.length,
    );
  }


  _loadData(int index, bool onRefresh) async {
    String path = "https://www.wanandroid.com/article/list/${index}/json";

    page = index;
    Dio dio = Dio();
    var respon = await dio.get(path);

    var date = HomeListResultEntity().fromJson(respon.data);

    if (index == 0) {
      list = date.data.datas;
    } else {
      list.addAll(date.data.datas);
    }

    setState(() {});
  }

  //banner
  @override
  _getBanner() async {
    var respon = await new Dio().get("https://www.wanandroid.com/banner/json");

    bannerResult = HomeBannerResultEntity().fromJson(respon.data);
    setState(() {});
  }
}
