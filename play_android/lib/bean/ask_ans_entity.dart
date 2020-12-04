import 'package:play_android/generated/json/base/json_convert_content.dart';
class AskAnsEntity with JsonConvert<AskAnsEntity> {
	AskAnsData data;
	int errorCode;
	String errorMsg;
}

class AskAnsData with JsonConvert<AskAnsData> {
	int curPage;
	List<AskAnsDataData> datas;
	int offset;
	bool over;
	int pageCount;
	int size;
	int total;
}

class AskAnsDataData with JsonConvert<AskAnsDataData> {
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
	List<AskAnsDataDatasTag> tags;
	String title;
	int type;
	int userId;
	int visible;
	int zan;
}

class AskAnsDataDatasTag with JsonConvert<AskAnsDataDatasTag> {
	String name;
	String url;
}
