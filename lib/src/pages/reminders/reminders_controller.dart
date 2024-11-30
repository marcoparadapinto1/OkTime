import 'package:get/get.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

class Reminder {
  String title;DateTime dateTime;

  Reminder({required this.title, required this.dateTime});
}

class RemindersController extends GetxController {
  RxList<Reminder> reminders = <Reminder>[].obs;

  void addReminder(Reminder reminder) {
    reminders.add(reminder);
    scheduleAlarm(reminder);
  }

  void scheduleAlarm(Reminder reminder) async {
    const int alarmId = 0; // ID único para la alarma

    await AndroidAlarmManager.oneShotAt(
      reminder.dateTime,
      alarmId,
          () {// Lógica para mostrar la notificación o reproducir un sonido
        // ... (Puedes usar flutter_local_notifications o audioplayers)
        print('Alarma activada para: ${reminder.title}'); // Ejemplo
      },
      exact: true,
      wakeup: true,
    );
  }
}