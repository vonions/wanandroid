import 'package:play_android/bean/jifen_entity.dart';

jifenEntityFromJson(JifenEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new JifenData().fromJson(json['data']);
	}
	if (json['errorCode'] != null) {
		data.errorCode = json['errorCode']?.toInt();
	}
	if (json['errorMsg'] != null) {
		data.errorMsg = json['errorMsg']?.toString();
	}
	return data;
}

Map<String, dynamic> jifenEntityToJson(JifenEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	data['errorCode'] = entity.errorCode;
	data['errorMsg'] = entity.errorMsg;
	return data;
}

jifenDataFromJson(JifenData data, Map<String, dynamic> json) {
	if (json['coinCount'] != null) {
		data.coinCount = json['coinCount']?.toInt();
	}
	if (json['rank'] != null) {
		data.rank = json['rank']?.toString();
	}
	if (json['userId'] != null) {
		data.userId = json['userId']?.toInt();
	}
	if (json['username'] != null) {
		data.username = json['username']?.toString();
	}
	return data;
}

Map<String, dynamic> jifenDataToJson(JifenData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['coinCount'] = entity.coinCount;
	data['rank'] = entity.rank;
	data['userId'] = entity.userId;
	data['username'] = entity.username;
	return data;
}