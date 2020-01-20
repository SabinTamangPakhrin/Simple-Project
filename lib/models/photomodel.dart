class PhotoModel {
  int id;
  String title;
  String url;
  String thumbnailUrl;
  bool liked;
  PhotoModel({this.id, this.url, this.thumbnailUrl,this.liked=false});

  factory PhotoModel.fromJson(Map<String,dynamic> parsedJson) {
    return PhotoModel(
      id: parsedJson['id'],
      url: parsedJson['url'],
      thumbnailUrl: parsedJson['thumbnailUrl']
    );
  }
}
