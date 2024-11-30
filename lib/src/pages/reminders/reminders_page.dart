import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/pages/reminders/reminders_controller.dart';
import 'package:intl/intl.dart';


class RemindersPage extends StatefulWidget {
  const RemindersPage({Key? key}) : super(key: key);

  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  final RemindersController controller = Get.put(RemindersController());
  final TextEditingController titleController = TextEditingController();
  DateTime? selectedDateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text('Recordatorios'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Título del recordatorio'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final DateTime? pickedDateTime = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDateTime != null && pickedDateTime != selectedDateTime) {
                  setState(() {
                    selectedDateTime = pickedDateTime;
                  });
                }
              },
              child: Text(selectedDateTime == null
                  ? 'Seleccionar fecha y hora'
                  : DateFormat('yyyy-MM-dd – kk:mm').format(selectedDateTime!)),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty && selectedDateTime != null) {
                  controller.addReminder(Reminder(
                    title: titleController.text,
                    dateTime: selectedDateTime!,
                  ));
                  titleController.clear();
                  setState(() {
                    selectedDateTime = null;
                  });
                  Get.snackbar('Recordatorio creado', 'El recordatorio se ha creado correctamente.');
                } else {
                  Get.snackbar('Error', 'Por favor, completa todos los campos.');
                }
              },
              child: const Text('Crear recordatorio'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: controller.reminders.length,
                itemBuilder: (context, index) {
                  return Obx(() => ListTile(
                    title: Text(controller.reminders[index].title),
                    subtitle: Text(DateFormat('yyyy-MM-dd – kk:mm').format(controller.reminders[index].dateTime)),
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}