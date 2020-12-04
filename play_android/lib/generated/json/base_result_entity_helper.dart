import 'package:play_android/bean/base_result_entity.dart';

baseResultEntityFromJson(BaseResultEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = json['data'];
	}
	if (json['errorCode'] != null) {
		data.errorCode = json['errorCode']?.toInt();
	}
	if (json['errorMsg'] != null) {
		data.errorMsg = json['errorMsg']?.toString();
	}
	return data;
}

Map<String, dynamic> baseResultEntityToJson(BaseResultEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['data'] = entity.data;
	data['errorCode'] = entity.errorCode;
	data['errorMsg'] = entity.errorMsg;
	return data;
}