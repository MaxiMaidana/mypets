class FurModel {
  final String id;
  final String type;
  final List<String> furs;

  FurModel({required this.id, required this.furs, required this.type});

  static FurModel fromJson(Map<String, dynamic> json) => FurModel(
        id: json['id'],
        type: json['type'],
        furs: List<String>.from(json['furs_type'].map((x) => x)),
      );
}
