import 'package:googleapis/calendar/v3.dart';
import 'package:mypets/data/models/pet/pet_model.dart';

class PetReminder {
  final PetModel petModel;
  final List<Event> lsEvents;

  PetReminder({required this.petModel, required this.lsEvents});
}
