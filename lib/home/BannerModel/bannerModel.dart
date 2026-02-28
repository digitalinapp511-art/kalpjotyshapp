class BannerModel {
  final String id;
  final String url;

  BannerModel({
    required this.id,
    required this.url,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['_id'],
      url: json['url'],
    );
  }
}