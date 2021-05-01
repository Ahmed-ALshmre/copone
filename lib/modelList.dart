class ModelListItem{
  List <dynamic> listEr;
  List <dynamic> listAr;
  List <dynamic> listCon;
  ModelListItem({this.listEr,this.listAr,this.listCon});
  ModelListItem.fromJson(Map<String, dynamic> json) {
    listEr = json['entitle'];
    listAr = json['artitle'];
    listCon = json['listContry'];
  }
  // ignore: missing_return
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entitle'] = this.listEr;
    data['artitle'] = this.listAr;
    data['listContry'] = this.listCon;
  }
}