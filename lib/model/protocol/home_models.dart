class BannerModel {
  String title;
  int id;
  String url;
  String imagePath;

  BannerModel.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        id = json["id"],
        url = json["url"],
        imagePath = json["imagePath"];

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "id": id,
      "url": url,
      "imagePath": imagePath,
    };
  }

  @override
  String toString() {
    return 'BannerModel{title: $title, id: $id, url: $url, imagePath: $imagePath}';
  }
}

///项目列表公用model
class ReposModel {
  int id;
  int originId;
  String title;
  String desc;
  String author;
  String link;
  String projectLink;
  String envelopePic;
  String superChapterName;
  int publishTime;
  bool collect;

  int type; //1项目，2文章
  bool isShowHeader;

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "originId": this.originId,
      "title": this.title,
      "desc": this.desc,
      "author": this.author,
      "link": this.link,
      "projectLink": this.projectLink,
      "envelopePic": this.envelopePic,
      "superChapterName": this.superChapterName,
      "publishTime": this.publishTime,
      "collect": this.collect,
      "type": this.type,
      "isShowHeader": this.isShowHeader,
    };
  }

  ReposModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        originId = json["originId"],
        title = json["title"],
        desc = json["desc"],
        author = json["author"],
        link = json["link"],
        projectLink = json["projectLink"],
        envelopePic = json["envelopePic"],
        superChapterName = json["superChapterName"],
        publishTime = json["publishTime"],
        collect = json["collect"],
        type = json["type"];

  @override
  String toString() {
    return 'ReposModel{id: $id, originId: $originId, title: $title, desc: $desc, author: $author,'
        ' link: $link, projectLink: $projectLink, envelopePic: $envelopePic, superChapterName: $superChapterName, '
        'publishTime: $publishTime, collect: $collect, type: $type, isShowHeader: $isShowHeader}';
  }
}
