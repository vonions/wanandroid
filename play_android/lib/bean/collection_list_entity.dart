import 'package:play_android/generated/json/base/json_convert_content.dart';

class CollectionListEntity with JsonConvert<CollectionListEntity> {
	CollectionListData data;
	int errorCode;
	String errorMsg;
}

class CollectionListData with JsonConvert<CollectionListData> {
	int curPage;
	List<CollectionListDataData> datas;
	int offset;
	bool over;
	int pageCount;
	int size;
	int total;
}

class CollectionListDataData with JsonConvert<CollectionListDataData> {
	String author;
	int chapterId;
	String chapterName;
	int courseId;
	String desc;
	String envelopePic;
	int id;
	String link;
	String niceDate;
	String origin;
	int originId;
	int publishTime;
	String title;
	int userId;
	int visible;
	int zan;
}
