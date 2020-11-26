
import 'package:banner/banner.dart';
import 'package:flutter/material.dart';

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
}
