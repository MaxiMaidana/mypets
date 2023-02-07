class PetModel {
  String name;
  String ownerId;
  String type;
  String race;
  List<String> reminders;
  String? birthday;
  String? photoUrl;

  PetModel({
    required this.name,
    required this.ownerId,
    required this.type,
    required this.race,
    required this.reminders,
    this.birthday,
    this.photoUrl,
  });

  static PetModel fromJson(Map<String, dynamic> json) => PetModel(
        name: json['name'],
        ownerId: json['ownerId'],
        type: json['type'],
        race: json['race'],
        reminders: List<String>.from(json['reminders']),
        birthday: json['birthday'],
        photoUrl: json['photoUrl'],
      );
}
