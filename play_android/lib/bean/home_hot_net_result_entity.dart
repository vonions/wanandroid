import 'package:play_android/generated/json/base/json_convert_content.dart';

class HomeHotNetResultEntity with JsonConvert<HomeHotNetResultEntity> {
	List<HomeHotNetResultData> data;
	int errorCode;
	String errorMsg;
}

class HomeHotNetResultData with JsonConvert<HomeHotNetResultData> {
	String icon;
	int id;
	String link;
	String name;
	int order;
	int visible;
}
