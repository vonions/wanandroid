import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:play_android/bean/hot_key_result_entity.dart';
import 'package:play_android/Util.dart';
import 'package:play_android/bean/search_result_entity.dart';
import 'package:play_android/home/DetailPage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toast/toast.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPage();
  }
}

class _SearchPage extends State<SearchPage> {
  HotKeyResultEntity entity;
  SearchResultEntity search;

  bool isSearch = false;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  String key = "";
  int page = 0;

  String searchKey = "";

  TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {


    if (entity == null) {
      _hotKeys();
    }

    return Scaffold(
        appBar: AppBar(
            title: Container(
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                autofocus: false,
                controller: _textController,
                decoration: InputDecoration(
                    hintText: key == "" ? "请输入需要搜索内容" : key,
                    hintStyle: TextStyle(fontSize: 14)),
                style: TextStyle(color: Colors.white, fontSize: 14),
                onChanged: (text) {
                  searchKey = text;
                },
              )),
              GestureDetector(
                child: Icon(Icons.search),
                onTap: () {
                  if (searchKey == "") {
                    Toast.show("请输入搜索内容", context);
                  } else {
                    _search(searchKey, 0);
                  }
                },
              )
            ],
          ),
        )),
        body: Container(
          child: Container(
            child: isSearch ? _ResultLayout() : _HotResult(),
          ),
        ));
//      return _ResultLayout();
  }

  _hotKeys() async {
    var result = await Dio().get("https://www.wanandroid.com//hotkey/json");
    entity = HotKeyResultEntity().fromJson(result.data);
    setState(() {});
  }

  //热词
  _HotResult() {
    if (entity == null) {
      return Container(
          alignment: Alignment.center, child: Util.LoadingWidget());
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(15),
            alignment: Alignment.centerLeft,
            child: Text(
              "搜索热词",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            child: Tags(
//              itemCount: hotNet.data.length > 10 ? 10 : hotNet.data.length,
              itemCount: entity.data.length,
              itemBuilder: (int index) {
                return Tooltip(
                  message: entity.data[index].name,
                  child: ItemTags(
                    index: index,
                    active: false,
                    title: entity.data[index].name,
                    onPressed: (net) {
//                      Navigator.push(context,
//                          MaterialPageRoute(builder: (context) {
//                            return DetailPage(
//                                entity.data[index].name, entity.data[index].link);
//                          }));

                      _search(entity.data[index].name, 0);
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

  //搜索 key
  _search(String key, int page) async {
    this.page = page;
    this.key = key;
    FormData formData = FormData.fromMap({"k": key});
    String url =
        "https://www.wanandroid.com/article/query/" + page.toString() + "/json";
    var respon = await Dio().post(url, data: formData);

    print(respon.data.toString());

    isSearch = true;
    if (page == 0) {
      search = SearchResultEntity().fromJson(respon.data);
      setState(() {
        _textController.text=key;
        searchKey=key;
      });
    } else {
      search.data.datas
          .addAll(SearchResultEntity().fromJson(respon.data).data.datas);
      setState(() {
        _textController.text=key;
        searchKey=key;
      });
    }
  }

  //搜索结果
  _ResultLayout() {
    return Scaffold(
        body: SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      footer: LinkFooter(),
      onRefresh: _onRefresh,
      onLoading: _onLoadMore,
      controller: _refreshController,
      child: _SearchResultItem(),
    ));
  }

  //搜索
  _SearchResultItem() {
    return CustomScrollView(slivers: [
      SliverList(
        delegate: SliverChildBuilderDelegate((context, i) {
          return Container(
            child: GestureDetector(
              child: _ItemCard(i),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DetailPage(
                      search.data.datas[i].title, search.data.datas[i].link);
                }));
              },
            ),
          );
        }, childCount: search.data.datas.length),
      )
    ]);
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
                "${search.data.datas[i].niceShareDate}",
                style: TextStyle(color: Colors.black54, fontSize: 13),
              )),
          Container(
            margin: EdgeInsets.only(left: 15, top: 15),
            child: Text(
              search.data.datas[i].title,
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.normal),
            ),
            alignment: Alignment.centerLeft,
          ),
          Container(
            margin: EdgeInsets.only(left: 15, top: 15, bottom: 15),
            child: Row(
              children: [
                Text(
                  "作者:${search.data.datas[i].shareUser}",
                  style: TextStyle(color: Colors.blue),
                ),
//                Expanded(child: SizedBox(),),
                Spacer(),
                Container(
                    margin: EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      child: Icon(
                        search.data.datas[i].collect
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onTap: () {
                        if (search.data.datas[i].collect) {
                          search.data.datas[i].collect = false;
                          setState(() {});
                        } else {
                          search.data.datas[i].collect = true;
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

  //刷新
  void _onRefresh() async {
    page = 0;
    await _search(key, page);
    _refreshController.refreshCompleted();
  }

  //加载更多
  void _onLoadMore() async {
    page = page + 1;
    await _search(key, page);
    _refreshController.loadComplete();
  }
}
