enum ReminderType { init, create, delete, update }

class ReminderEvent {
  final ReminderType type;
  final String reminderId;

  ReminderEvent({required this.type, required this.reminderId});

  static ReminderEvent init() =>
      ReminderEvent(type: ReminderType.init, reminderId: '');
}
