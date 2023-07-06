import 'package:equatable/equatable.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:mypets/data/models/pet/pet_model.dart';

class PetReminder extends Equatable {
  final PetModel petModel;
  final List<Event> lsEvents;

  const PetReminder({
    required this.petModel,
    required this.lsEvents,
  });

  PetReminder copyWith({
    PetModel? petModel,
    List<Event>? lsEvents,
  }) =>
      PetReminder(
        petModel: petModel ?? this.petModel,
        lsEvents: lsEvents ?? this.lsEvents,
      );

  @override
  List<Object?> get props => [petModel, lsEvents];

  @override
  bool? get stringify => true;
}
