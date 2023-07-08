import 'package:equatable/equatable.dart';
import 'package:googleapis/calendar/v3.dart';

import 'vaccine_model.dart';

class PetModel extends Equatable {
  final String species;
  final String name;
  final String sex;
  final List<String> owners;
  final String birthDate;
  final List<String> remindersId;
  final String? id;
  final String? breed;
  final String? photoUrl;
  final String? fur;
  final String? size;
  final String? weigth;
  final VaccineModel? vaccine;
  final List<Event>? lsEvents;

  const PetModel({
    required this.species,
    required this.name,
    required this.sex,
    required this.owners,
    required this.birthDate,
    required this.remindersId,
    this.id,
    this.breed,
    this.photoUrl,
    this.fur,
    this.size,
    this.weigth,
    this.vaccine,
    this.lsEvents,
  });

  PetModel copyWith({
    String? species,
    String? name,
    String? sex,
    List<String>? owners,
    String? birthDate,
    List<String>? remindersId,
    String? id,
    String? breed,
    String? photoUrl,
    String? fur,
    String? size,
    String? weigth,
    VaccineModel? vaccine,
    List<Event>? lsEvents,
  }) =>
      PetModel(
        species: species ?? this.species,
        name: name ?? this.name,
        sex: sex ?? this.sex,
        owners: owners ?? this.owners,
        birthDate: birthDate ?? this.birthDate,
        remindersId: remindersId ?? this.remindersId,
        id: id ?? this.id,
        breed: breed ?? this.breed,
        photoUrl: photoUrl ?? this.photoUrl,
        fur: fur ?? this.fur,
        size: size ?? this.size,
        weigth: weigth ?? this.weigth,
        vaccine: vaccine ?? this.vaccine,
        lsEvents: lsEvents ?? this.lsEvents,
      );

  @override
  List<Object?> get props => [
        species,
        name,
        sex,
        owners,
        birthDate,
        remindersId,
        id,
        breed,
        photoUrl,
        fur,
        size,
        weigth,
        vaccine,
        lsEvents
      ];

  @override
  bool? get stringify => true;

  static PetModel fromJson(Map<String, dynamic> json) => PetModel(
        species: json['species'],
        name: json['name'],
        sex: json['sex'],
        owners: List<String>.from(json['owners']),
        birthDate: json['birthDate'],
        remindersId: List<String>.from(json['reminders']),
        id: json['id'],
        breed: json['breed'],
        photoUrl: json['photoUrl'],
        fur: json['fur'],
        size: json['size'],
        weigth: json['weigth'],
        vaccine: json['vaccine'],
        lsEvents: [],
      );

  static PetModel init() => PetModel(
        species: '',
        name: '',
        sex: '',
        owners: [],
        birthDate: '',
        remindersId: [],
        id: '',
        breed: '',
        photoUrl: '',
        fur: '',
        size: '',
        weigth: '',
        vaccine: VaccineModel.init(),
        lsEvents: [],
      );

  Map<String, dynamic> toJson() => {
        'species': species,
        'name': name,
        'sex': sex,
        'owners': owners,
        'birthDate': birthDate,
        'reminders': remindersId,
        'id': id,
        'breed': breed,
        'photoUrl': photoUrl,
        'fur': fur,
        'size': size,
        'weigth': weigth,
      };
}
