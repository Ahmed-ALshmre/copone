class ItemModel {
  String title;
  String uid;
  String code;
  String thumbnailUrl;
  String arTitle;
  String enTitle;
  String contry;
  String titleEn;
  int conter;
  String image;
  String titleAr;
  String id;

  ItemModel(
      {this.uid,
      this.image,
      this.titleAr,
      this.contry,
      this.arTitle,
      this.enTitle,
        this.title,this.conter,
        this.code,
        this.id,
        this.titleEn,
        this.thumbnailUrl,
      });
  ItemModel.fromJson(Map<String, dynamic> json) {
    title = json['titleAr'];
    id = json['id'];
    titleAr = json['titleAr'];
    image = json['thumbnailUrl'];
    contry = json['name_c'];
    arTitle=json['artitle'];
    enTitle=json['entitle'];
    uid = json['uid'];
    conter = json['conter'];
    code = json['code'];
    thumbnailUrl = json['image'];
    titleEn = json['titleEn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titleAr'] = this.title;
    data['artitle']=this.arTitle;
    data['entitle']=this.enTitle;
     data['titleAr']=this.titleAr;
    data['id'] = this.id;
    data['thumbnailUrl']=this.image;
    data['name_c'] = this.contry;
    data['uid'] = this.uid;
    data['conter'] = this.conter;
    data['thumbnailUrl']=this.image;
    data['code'] = this.code;
    data['titleEn'] = this.titleEn;
    data['image'] = this.thumbnailUrl;
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
