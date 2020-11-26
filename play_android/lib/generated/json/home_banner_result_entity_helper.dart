import 'package:play_android/bean/home_banner_result_entity.dart';

homeBannerResultEntityFromJson(HomeBannerResultEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new List<HomeBannerResultData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new HomeBannerResultData().fromJson(v));
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

Map<String, dynamic> homeBannerResultEntityToJson(HomeBannerResultEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	data['errorCode'] = entity.errorCode;
	data['errorMsg'] = entity.errorMsg;
	return data;
}

homeBannerResultDataFromJson(HomeBannerResultData data, Map<String, dynamic> json) {
	if (json['desc'] != null) {
		data.desc = json['desc']?.toString();
	}
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['imagePath'] != null) {
		data.imagePath = json['imagePath']?.toString();
	}
	if (json['isVisible'] != null) {
		data.isVisible = json['isVisible']?.toInt();
	}
	if (json['order'] != null) {
		data.order = json['order']?.toInt();
	}
	if (json['title'] != null) {
		data.title = json['title']?.toString();
	}
	if (json['type'] != null) {
		data.type = json['type']?.toInt();
	}
	if (json['url'] != null) {
		data.url = json['url']?.toString();
	}
	return data;
}

Map<String, dynamic> homeBannerResultDataToJson(HomeBannerResultData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['desc'] = entity.desc;
	data['id'] = entity.id;
	data['imagePath'] = entity.imagePath;
	data['isVisible'] = entity.isVisible;
	data['order'] = entity.order;
	data['title'] = entity.title;
	data['type'] = entity.type;
	data['url'] = entity.url;
	return data;
}