
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:play_android/NetUtil.dart';
import 'package:play_android/Util.dart';
import 'package:play_android/bean/ask_ans_entity.dart';
import 'package:play_android/bean/interviewabout_entity.dart';
import 'package:play_android/home/DetailPage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InterviewAboutPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return  _InterviewAboutPage();
  }

}
class _InterviewAboutPage extends State<InterviewAboutPage>{
  InterviewaboutEntity entity=null;
  int page=0;

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {

    if(entity==null){
      _getDailyAsk(0);
      return Scaffold(
        appBar: AppBar(
          title: Text("面试指南"),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Util.LoadingWidget(),
        ),
      );
    }else{
      return Scaffold(
        appBar: AppBar(
          title: Text("面试指南"),
        ),
        body: _result(),
      );
    }



  }


  _onRefresh()async{
    page=1;
    await _getDailyAsk(page);
    _refreshController.refreshCompleted();
  }
  _onLoadMore() async{
    page++;
    await _getDailyAsk(page);
    _refreshController.loadComplete();

  }

  Widget _result(){
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

  _getDailyAsk(int page)async{

    String url="https://www.wanandroid.com/article/list/$page/json?cid=73";

    var respon=await NetUtil.get(url);

    if(page==0){
      entity=InterviewaboutEntity().fromJson(respon);
    }else{
      entity.data.datas.addAll(InterviewaboutEntity().data.datas);
    }

    setState(() {

    });
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
                "${entity.data.datas[i].niceShareDate}",
                style: TextStyle(color: Colors.black54, fontSize: 13),
              )),
          Container(
            margin: EdgeInsets.only(left: 15, top: 15),
            child: Text(
              entity.data.datas[i].title,
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.normal),
            ),
            alignment: Alignment.centerLeft,
          ),
          Container(
            margin: EdgeInsets.only(left: 15, top: 15, bottom: 15),
            child: Row(
              children: [
                Text(
                  "作者:${entity.data.datas[i].author}",
                  style: TextStyle(color: Colors.blue),
                ),
//                Expanded(child: SizedBox(),),
                Spacer(),
                Container(
                    margin: EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      child: Icon(
                        entity.data.datas[i].collect
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onTap: () {
                        if (entity.data.datas[i].collect) {
                          _unLike(entity.data.datas[i].id);
                          entity.data.datas[i].collect = false;
                          setState(() {});
                        } else {
                          _like(entity.data.datas[i].id);
                          entity.data.datas[i].collect = true;
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
  Widget _ListView() {
    return ListView.builder(
      itemBuilder: (c, i) => GestureDetector(
        child: _ItemCard(i),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DetailPage(entity.data.datas[i].title, entity.data.datas[i].link);
          }));
        },
      ),
      itemCount: entity.data.datas.length,
    );
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

  @override
  void initState() {
    super.initState();
  }


}