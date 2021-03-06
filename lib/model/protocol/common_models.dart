import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';

///国际化语言数据模型
class LanguageModel {
  String titleId;
  String languageCode;
  String countryCode;
  bool isSelected;

  LanguageModel(this.titleId, this.languageCode, this.countryCode, {this.isSelected: false});

  //// 类的命名构造方法
  LanguageModel.fromJson(Map<String, dynamic> json) {
    titleId = json['titleId'];
    languageCode = json['languageCode'];
    countryCode = json['countryCode'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() => {
        'titleId': titleId,
        'languageCode': languageCode,
        'countryCode': countryCode,
        'isSelected': isSelected,
      };

  @override
  String toString() {
    return 'LanguageModel{titleId: $titleId, languageCode: $languageCode, countryCode: $countryCode, isSelected: $isSelected}';
  }
}

///闪屏页数据实体模型
class SplashModel {
  String title;
  String content;
  String url;
  String imgUrl;

  SplashModel({this.title, this.content, this.url, this.imgUrl});

  SplashModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        content = json['content'],
        url = json['url'],
        imgUrl = json['imgUrl'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'url': url,
        'imgUrl': imgUrl,
      };

  @override
  String toString() {
    return 'SplashModel{title: $title, content: $content, url: $url, imgUrl: $imgUrl}';
  }
}

///软件版本数据模型
class VersionControlModel {
  String title;
  String content;
  String url;
  String version;

  VersionControlModel({this.title, this.content, this.url, this.version});

  VersionControlModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        content = json['content'],
        url = json['url'],
        version = json['version'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'url': url,
        'version': version,
      };

  @override
  String toString() {
    return 'VersionControlModel{title: $title, content: $content, url: $url, version: $version}';
  }
}

///列表item公用数据模型
class ComModel {
  String version;
  String title;
  String content;
  String extra;
  String url;
  String imgUrl;
  String author;
  String updatedAt;

  int typeId;
  String titleId;

  Widget page;

  ComModel(
      {this.version,
      this.title,
      this.content,
      this.extra,
      this.url,
      this.imgUrl,
      this.author,
      this.updatedAt,
      this.typeId,
      this.titleId,
      this.page});

  ComModel.fromJson(Map<String, dynamic> json)
      : version = json['version'],
        title = json['title'],
        content = json['content'],
        extra = json['extra'],
        url = json['url'],
        imgUrl = json['imgUrl'],
        author = json['author'],
        updatedAt = json['updatedAt'];

  Map<String, dynamic> toJson() => {
        'version': version,
        'title': title,
        'content': content,
        'extra': extra,
        'url': url,
        'imgUrl': imgUrl,
        'author': author,
        'updatedAt': updatedAt,
      };

  @override
  String toString() {
    return 'ComModel{version: $version, title: $title, content: $content, extra: $extra, url: $url, imgUrl: $imgUrl,'
        ' author: $author, updatedAt: $updatedAt, typeId: $typeId, titleId: $titleId, page: $page}';
  }
}

///通用数据实体
class ComData {
  int size;
  List datas;

  ComData.fromJson(Map<String, dynamic> json)
      : size = json["size"],
        datas = json["datas"];
}

///通用请求参数
class ComReq {
  int cid;

  ComReq(this.cid);

  ComReq.fromJson(Map<String, dynamic> json) : cid = json["cid"];

  Map<String, dynamic> toJson() {
    return {
      "cid": this.cid,
    };
  }
}

///树形数据实体
class TreeModel extends ISuspensionBean{
  int id;
  String name;
  List<TreeModel> children;

  String tagIndex;//标签排序

  TreeModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        children = (json["children"] as List)
            ?.map((e) => e == null ? null : new TreeModel.fromJson(e as Map<String, dynamic>))
            ?.toList();

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "children": this.children,
    };
  }

  @override
  String toString() {
    return 'TreeModel{id: $id, tagIndex: $tagIndex, name: $name, children: $children}';
  }

  @override
  String getSuspensionTag() {
    return tagIndex;
  }
}
