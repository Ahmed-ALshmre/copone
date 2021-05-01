class ItemModel {
  String title;
  String code;
  String thumbnailUrl;
  String titleEn;
  int conter;
  String id;
  ItemModel(
      {this.title,this.conter,
        this.code,
        this.id,
        this.titleEn,
        this.thumbnailUrl,
      });
  ItemModel.fromJson(Map<String, dynamic> json) {
    title = json['titleAr'];
    id = json['id'];
    conter = json['conter'];
    code = json['code'];
    thumbnailUrl = json['thumbnailUrl'];
    titleEn = json['titleEn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titleAr'] = this.title;
    data['id'] = this.id;
    data['conter'] = this.conter;
    data['code'] = this.code;
    data['titleEn'] = this.titleEn;
    data['thumbnailUrl'] = this.thumbnailUrl;
    return data;
  }
}

class PublishedDate {
  String date;

  PublishedDate({this.date});

  PublishedDate.fromJson(Map<String, dynamic> json) {
    date = json['$date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$date'] = this.date;
    return data;
  }
}
