

import 'package:banner/banner.dart';
import 'package:flutter/material.dart';
import 'package:play_android/search/SearchPage.dart';
import 'package:play_android/widget/IconText.dart';

import 'bean/home_banner_result_entity.dart';
import 'home/DetailPage.dart';

class Util {

  //loading
  static LoadingWidget() {
    return new CircularProgressIndicator(
      strokeWidth: 4.0,
      backgroundColor: Colors.blue,
      valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
    );
  }

  //首页banner
  static  bannerView(HomeBannerResultEntity bannerResult,BuildContext context,) {
    return BannerView(
      data: bannerResult.data,
      buildShowView: (index, date) {
        print(date.toString());
        return Stack(
          children: [
            Image.network(
              date.imagePath,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              child: Text(
                date.title,
                style: TextStyle(
                    color: Colors.white,
                    backgroundColor: Colors.black26,
                    fontSize: 18),
              ),
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.all(5),
            )
          ],
        );
      },
      onBannerClickListener: (index, data) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailPage(data.title, data.url);
        }));
      },
    );
  }


  static topToolsBar(context){
   return  AppBar(
      title: Row(
        children: [
          Text("玩安卓"),
          Spacer(),
          GestureDetector(
            child:IconText(
              "",
              style: TextStyle(fontSize: 18),
              padding: EdgeInsets.only(left: 10,right: 5),
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: 32,
              ),
            ),
            onTap: (){

              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return new SearchPage();
              }));
            },
          )

        ],
      ),
    );
  }
}
