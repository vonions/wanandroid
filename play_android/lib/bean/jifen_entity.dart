import 'package:play_android/generated/json/base/json_convert_content.dart';

class JifenEntity with JsonConvert<JifenEntity> {
	JifenData data;
	int errorCode;
	String errorMsg;
}

class JifenData with JsonConvert<JifenData> {
	int coinCount;
	String rank;
	int userId;
	String username;
}
