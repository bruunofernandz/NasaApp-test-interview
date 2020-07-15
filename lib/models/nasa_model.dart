class NasaModel {
  String date;
  String explanation;
  String hdurl;
  String mediatype;
  String serviceVersion;
  String title;
  String url;

  NasaModel(
      {this.date,
      this.explanation,
      this.hdurl,
      this.mediatype,
      this.serviceVersion,
      this.title,
      this.url});

  factory NasaModel.fromJson(Map<String, dynamic> json) {
    var data = NasaModel(
      date: json['date'].toString(),
      explanation: json['explanation'],
      hdurl: json['hdurl'],
      mediatype: json['mediatype'],
      serviceVersion: json['serviceVersion'],
      title: json['title'],
      url: json['url'],
    );

    return data;
  }
}
