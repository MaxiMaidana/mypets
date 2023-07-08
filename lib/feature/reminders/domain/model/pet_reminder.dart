import 'package:equatable/equatable.dart';
import 'package:googleapis/calendar/v3.dart';

class PetReminder extends Equatable {
  final String idPet;
  final String name;
  final List<Event> lsEvents;

  const PetReminder({
    required this.idPet,
    required this.name,
    required this.lsEvents,
  });

  PetReminder copyWith({
    String? idPet,
    String? name,
    List<Event>? lsEvents,
  }) =>
      PetReminder(
        idPet: idPet ?? this.idPet,
        name: name ?? this.name,
        lsEvents: lsEvents ?? this.lsEvents,
      );

  @override
  List<Object?> get props => [idPet, lsEvents];

  @override
  bool? get stringify => true;
}
