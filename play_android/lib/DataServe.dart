import 'package:play_android/NetUtil.dart';
import 'package:play_android/Util.dart';
import 'package:play_android/bean/jifen_entity.dart';

import 'Api.dart';

class DataServe {
  //获取用户积分
  Future<JifenEntity> getCoin() async {
    var rspon = await NetUtil.get(Api.coin);
    return JifenEntity().fromJson(rspon);
  }
}
