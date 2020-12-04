import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:play_android/bean/base_result_entity.dart';
import 'package:toast/toast.dart';

class NetUtil {
  static get(String url) async {
    var dio = Dio();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appdocPath = appDocDir.path;
    var cookieJar = PersistCookieJar(dir: appdocPath + "/.cookies/");
    dio.interceptors.add(CookieManager(cookieJar));
    var respon = await dio.get(url);
    var result = BaseResultEntity().fromJson(respon.data);
    print(result.data);
    if (result.errorCode != 0) {
      return "";
    }
    return respon.data;
  }

  static post(String url, FormData json) async {
    var dio = Dio();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appdocPath = appDocDir.path;
    var cookieJar = PersistCookieJar(dir: appdocPath + "/.cookies/");
    dio.interceptors.add(CookieManager(cookieJar));
    var respon = await dio.post(url, data: json);
    var result = BaseResultEntity().fromJson(respon.data);
    print(result.data);
    if (result.errorCode != 0) {
      return "";
    }
    return respon.data;
  }
}
