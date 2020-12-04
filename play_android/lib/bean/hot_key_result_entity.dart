import 'package:play_android/generated/json/base/json_convert_content.dart';

class HotKeyResultEntity with JsonConvert<HotKeyResultEntity> {
	List<HotKeyResultData> data;
	int errorCode;
	String errorMsg;
}

class HotKeyResultData with JsonConvert<HotKeyResultData> {
	int id;
	String link;
	String name;
	int order;
	int visible;
}
