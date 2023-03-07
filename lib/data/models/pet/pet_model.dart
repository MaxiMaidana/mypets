import 'vaccine_model.dart';

class PetModel {
  String species;
  String name;
  String sex;
  List<String> owners;
  String birthDate;
  List<String> reminders;
  String? id;
  String? breed;
  String? photoUrl;
  String? fur;
  String? size;
  String? weigth;
  VaccineModel? vaccine;

  PetModel({
    required this.species,
    required this.name,
    required this.sex,
    required this.owners,
    required this.birthDate,
    required this.reminders,
    this.id,
    this.breed,
    this.photoUrl,
    this.fur,
    this.size,
    this.weigth,
    this.vaccine,
  });

  static PetModel fromJson(Map<String, dynamic> json) => PetModel(
        species: json['species'],
        name: json['name'],
        sex: json['sex'],
        owners: List<String>.from(json['owners']),
        birthDate: json['birthDate'],
        reminders: List<String>.from(json['reminders']),
        id: json['id'],
        breed: json['breed'],
        photoUrl: json['photoUrl'],
        fur: json['fur'],
        size: json['size'],
        weigth: json['weigth'],
        vaccine: json['vaccine'],
      );

  static PetModel init() => PetModel(
        species: '',
        name: '',
        sex: '',
        owners: [],
        birthDate: '',
        reminders: [],
        id: '',
        breed: '',
        photoUrl: '',
        fur: '',
        size: '',
        weigth: '',
        vaccine: VaccineModel.init(),
      );

  Map<String, dynamic> toJson() => {
        'species': species,
        'name': name,
        'sex': sex,
        'owners': owners,
        'birthDate': birthDate,
        'reminders': reminders,
        'id': id,
        'breed': breed,
        'photoUrl': photoUrl,
        'fur': fur,
        'size': size,
        'weigth': weigth,
      };
}
