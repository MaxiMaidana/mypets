class AdModel {
  final String title;
  final String imageUrl;
  final String url;

  AdModel({required this.title, required this.imageUrl, required this.url});

  static AdModel fromJson(Map<String, dynamic> json) => AdModel(
        title: json['title'],
        imageUrl: json['imageUrl'],
        url: json['url'],
      );
}
