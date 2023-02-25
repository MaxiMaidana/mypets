class PetModel {
  int id;
  String name;
  String ownerId;
  String type;
  String race;
  List<String> reminders;
  String? birthday;
  String? photoUrl;

  PetModel({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.type,
    required this.race,
    required this.reminders,
    this.birthday,
    this.photoUrl,
  });

  static PetModel fromJson(Map<String, dynamic> json) => PetModel(
        id: json['id'],
        name: json['name'],
        ownerId: json['ownerId'],
        type: json['type'],
        race: json['race'],
        reminders: List<String>.from(json['reminders']),
        birthday: json['birthday'],
        photoUrl: json['photoUrl'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'ownerId': ownerId,
        'type': type,
        'race': race,
        'reminders': reminders,
        'birthday': birthday,
        'photoUrl': photoUrl,
      };
}
