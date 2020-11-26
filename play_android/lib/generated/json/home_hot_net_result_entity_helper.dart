import 'package:play_android/bean/home_hot_net_result_entity.dart';

homeHotNetResultEntityFromJson(HomeHotNetResultEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new List<HomeHotNetResultData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new HomeHotNetResultData().fromJson(v));
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

Map<String, dynamic> homeHotNetResultEntityToJson(HomeHotNetResultEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	data['errorCode'] = entity.errorCode;
	data['errorMsg'] = entity.errorMsg;
	return data;
}

homeHotNetResultDataFromJson(HomeHotNetResultData data, Map<String, dynamic> json) {
	if (json['icon'] != null) {
		data.icon = json['icon']?.toString();
	}
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

Map<String, dynamic> homeHotNetResultDataToJson(HomeHotNetResultData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['icon'] = entity.icon;
	data['id'] = entity.id;
	data['link'] = entity.link;
	data['name'] = entity.name;
	data['order'] = entity.order;
	data['visible'] = entity.visible;
	return data;
}