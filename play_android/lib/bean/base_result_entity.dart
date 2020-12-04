import 'package:play_android/generated/json/base/json_convert_content.dart';

class BaseResultEntity with JsonConvert<BaseResultEntity> {
	dynamic data;
	int errorCode;
	String errorMsg;
}
