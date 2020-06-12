class BannerModel {
  String title;
  String id;
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
