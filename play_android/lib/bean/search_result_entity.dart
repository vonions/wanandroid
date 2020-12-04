import 'package:play_android/generated/json/base/json_convert_content.dart';

class SearchResultEntity with JsonConvert<SearchResultEntity> {
	SearchResultData data;
	int errorCode;
	String errorMsg;
}

class SearchResultData with JsonConvert<SearchResultData> {
	int curPage;
	List<SearchResultDataData> datas;
	int offset;
	bool over;
	int pageCount;
	int size;
	int total;
}

class SearchResultDataData with JsonConvert<SearchResultDataData> {
	String apkLink;
	int audit;
	String author;
	bool canEdit;
	int chapterId;
	String chapterName;
	bool collect;
	int courseId;
	String desc;
	String descMd;
	String envelopePic;
	bool fresh;
	int id;
	String link;
	String niceDate;
	String niceShareDate;
	String origin;
	String prefix;
	String projectLink;
	int publishTime;
	int realSuperChapterId;
	int selfVisible;
	int shareDate;
	String shareUser;
	int superChapterId;
	String superChapterName;
	List<dynamic> tags;
	String title;
	int type;
	int userId;
	int visible;
	int zan;
}
