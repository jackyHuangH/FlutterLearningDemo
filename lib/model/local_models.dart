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
