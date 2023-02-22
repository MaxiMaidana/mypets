class UserModel {
  String name;
  String lastName;
  bool emailVerified;
  String urlPhoto;
  String dni;
  String phone;
  List<String> petsId;

  UserModel({
    required this.name,
    required this.lastName,
    required this.dni,
    required this.phone,
    required this.urlPhoto,
    required this.emailVerified,
    required this.petsId,
  });

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        lastName: json['lastName'],
        dni: json['dni'],
        phone: json['phone'],
        urlPhoto: json['urlPhoto'],
        emailVerified: json['emailVerified'],
        petsId: List<String>.from(json['petsId']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'lastName': lastName,
        'dni': dni,
        'phone': phone,
        'urlPhoto': urlPhoto,
        'emailVerified': emailVerified,
        'petsId': petsId,
      };
}
