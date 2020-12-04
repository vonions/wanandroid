import 'package:play_android/generated/json/base/json_convert_content.dart';

class LoginResultEntity with JsonConvert<LoginResultEntity> {
	LoginResultData data;
	int errorCode;
	String errorMsg;
}

class LoginResultData with JsonConvert<LoginResultData> {
	bool admin;
	List<dynamic> chapterTops;
	int coinCount;
	List<dynamic> collectIds;
	String email;
	String icon;
	int id;
	String nickname;
	String password;
	String publicName;
	String token;
	int type;
	String username;
}
