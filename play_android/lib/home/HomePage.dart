import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:play_android/NetUtil.dart';
import 'package:play_android/bean/home_banner_result_entity.dart';
import 'package:play_android/bean/home_list_result_entity.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:play_android/Util.dart';

import '../DataServe.dart';
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
        appBar: Util.topToolsBar(context),
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

  //首页item列表
  Widget _ItemCard(i) {
    return Card(
      margin: EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Column(
        children: [
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 15, top: 15),
              child: Text(
                "${list[i].niceShareDate}",
                style: TextStyle(color: Colors.black54, fontSize: 13),
              )),
          Container(
            margin: EdgeInsets.only(left: 15, top: 15),
            child: Text(
              list[i].title,
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.normal),
            ),
            alignment: Alignment.centerLeft,
          ),
          Container(
            margin: EdgeInsets.only(left: 15, top: 15, bottom: 15),
            child: Row(
              children: [
                Text(
                  "作者:${list[i].shareUser}",
                  style: TextStyle(color: Colors.blue),
                ),
//                Expanded(child: SizedBox(),),
                Spacer(),
                Container(
                    margin: EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      child: Icon(
                        list[i].collect
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onTap: () {
                        if (list[i].collect) {
                          _unLike(list[i].id);
                          list[i].collect = false;
                          setState(() {});
                        } else {
                          _like(list[i].id);
                          list[i].collect = true;
                          setState(() {});
                        }
                      },
                    ))
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

  //暂时废弃
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
                    Text(
                      "作者:${list[i].shareUser}",
                      style: TextStyle(color: Colors.blue),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Text("时间:${list[i].niceShareDate}")),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.favorite_border),
                    )
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
    var respon = await NetUtil.get(path);

    var date = HomeListResultEntity().fromJson(respon);

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

  //收藏
  _like(int id) {
    String url = "https://www.wanandroid.com/lg/collect/$id/json";

    NetUtil.post(url, FormData.fromMap({"id": id}));
  }

  //取消收藏
  _unLike(int id) {
    String url = "https://www.wanandroid.com/lg/uncollect_originId/$id/json";

    NetUtil.post(url, FormData.fromMap({"id": id}));
  }
}

class $ {}
