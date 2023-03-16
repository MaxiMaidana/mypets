class SizeModel {
  final String id;
  final String type;
  final List<String> sizes;

  SizeModel({required this.id, required this.sizes, required this.type});

  static SizeModel fromJson(Map<String, dynamic> json) => SizeModel(
        id: json['id'],
        type: json['type'],
        sizes: List<String>.from(json['sizes'].map((x) => x)),
      );
}
