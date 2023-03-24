import '../pet/pet_model.dart';

class UserModel {
  String? id;
  String name;
  String lastName;
  String email;
  bool emailVerified;
  String urlPhoto;
  String dni;
  String phone;
  List<PetModel> pets;

  UserModel({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.dni,
    required this.phone,
    required this.urlPhoto,
    required this.emailVerified,
    required this.pets,
  });

  static UserModel initEmpty() => UserModel(
        id: '',
        name: '',
        lastName: '',
        email: '',
        dni: '',
        phone: '',
        urlPhoto: '',
        emailVerified: false,
        pets: [],
      );

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        lastName: json['lastName'],
        email: json['email'],
        dni: json['dni'],
        phone: json['phone'],
        urlPhoto: json['urlPhoto'],
        emailVerified: json['emailVerified'],
        pets:
            List<PetModel>.from(json['pets'].map((x) => PetModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'lastName': lastName,
        'email': email,
        'dni': dni,
        'phone': phone,
        'urlPhoto': urlPhoto,
        'emailVerified': emailVerified,
        'pets': pets,
      };
}
