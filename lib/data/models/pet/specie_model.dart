class SpecieModel {
  final String id;
  final String type;
  final List<String> breeds;

  SpecieModel({required this.id, required this.type, required this.breeds});

  static SpecieModel fromJson(Map<String, dynamic> json) => SpecieModel(
        id: json['id'],
        type: json['type'],
        breeds: List<String>.from(json['species'].map((x) => x)),
      );
}
