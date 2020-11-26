import 'package:play_android/generated/json/base/json_convert_content.dart';

class HomeBannerResultEntity with JsonConvert<HomeBannerResultEntity> {
	List<HomeBannerResultData> data;
	int errorCode;
	String errorMsg;
}

class HomeBannerResultData with JsonConvert<HomeBannerResultData> {
	String desc;
	int id;
	String imagePath;
	int isVisible;
	int order;
	String title;
	int type;
	String url;
}
