class PetModel {
  int? id;
  String name;
  String ownerId;
  String type;
  String race;
  String sex;
  List<String> reminders;
  String? birthday;
  String? photoUrl;

  PetModel({
    required this.name,
    required this.ownerId,
    required this.type,
    required this.race,
    required this.sex,
    required this.reminders,
    this.id,
    this.birthday,
    this.photoUrl,
  });

  static PetModel fromJson(Map<String, dynamic> json) => PetModel(
        id: json['id'],
        name: json['name'],
        ownerId: json['ownerId'],
        type: json['type'],
        race: json['race'],
        sex: json['sex'],
        reminders: List<String>.from(json['reminders']),
        birthday: json['birthday'],
        photoUrl: json['photoUrl'],
      );

  static PetModel init() => PetModel(
        name: '',
        ownerId: '',
        type: '',
        race: '',
        sex: '',
        reminders: [],
        birthday: '',
        photoUrl: '',
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'ownerId': ownerId,
        'type': type,
        'race': race,
        'sex': sex,
        'reminders': reminders,
        'birthday': birthday,
        'photoUrl': photoUrl,
      };
}
