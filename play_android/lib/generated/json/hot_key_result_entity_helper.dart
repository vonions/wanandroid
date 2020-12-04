import 'package:play_android/bean/hot_key_result_entity.dart';

hotKeyResultEntityFromJson(HotKeyResultEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new List<HotKeyResultData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new HotKeyResultData().fromJson(v));
		});
	}
	if (json['errorCode'] != null) {
		data.errorCode = json['errorCode']?.toInt();
	}
	if (json['errorMsg'] != null) {
		data.errorMsg = json['errorMsg']?.toString();
	}
	return data;
}

Map<String, dynamic> hotKeyResultEntityToJson(HotKeyResultEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	data['errorCode'] = entity.errorCode;
	data['errorMsg'] = entity.errorMsg;
	return data;
}

hotKeyResultDataFromJson(HotKeyResultData data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['link'] != null) {
		data.link = json['link']?.toString();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['order'] != null) {
		data.order = json['order']?.toInt();
	}
	if (json['visible'] != null) {
		data.visible = json['visible']?.toInt();
	}
	return data;
}

Map<String, dynamic> hotKeyResultDataToJson(HotKeyResultData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['link'] = entity.link;
	data['name'] = entity.name;
	data['order'] = entity.order;
	data['visible'] = entity.visible;
	return data;
}