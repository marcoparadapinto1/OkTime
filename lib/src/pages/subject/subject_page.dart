import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:udemy_flutter_delivery/src/pages/subject/subject_controller.dart';

class SubjectPage extends StatefulWidget {
  const SubjectPage({Key? key}) : super(key: key);

  @override
  State<SubjectPage> createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectPage> {
  final SubjectController controller = Get.put(SubjectController());
  final TextEditingController subjectNameController = TextEditingController();
  final TextEditingController milestoneTitleController = TextEditingController();
  DateTime? selectedMilestoneDate;
  Importance selectedMilestoneImportance = Importance.low;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ramos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Formulario para ingresar ramos/asignaturas
            TextField(
              controller: subjectNameController,
              decoration: const InputDecoration(labelText: 'Nombre del ramo'),
            ),
            ElevatedButton(
              onPressed: () {
                if (subjectNameController.text.isNotEmpty) {
                  controller.addSubject(Subject(name: subjectNameController.text));
                  subjectNameController.clear();
                  Get.snackbar('Ramo agregado', 'El ramo se ha agregado correctamente.');
                } else {
                  Get.snackbar('Error', 'Por favor, ingresa el nombre del ramo.');
                }
              },
              child: const Text('Agregar ramo'),
            ),
            const SizedBox(height: 16),
            // Lista de ramos/asignaturas existentes
            Obx(() => controller.subjects.isNotEmpty
                ? DropdownButton<Subject>(
              value: controller.subjects.isNotEmpty ? controller.subjects[0] : null,
              onChanged: (Subject? newValue) {
                setState(() {}); // Actualiza el estado para mostrar el formulario de hitos
              },
              items: controller.subjects.map((Subject subject) {
                return DropdownMenuItem<Subject>(
                  value: subject,
                  child: Text(subject.name),
                );
              }).toList(),
            )
                : const Text('No hay ramos ingresados.')),
            const SizedBox(height: 16),
            // Formulario para agregar hitos a un ramo/asignatura
            Obx(() {
              final selectedSubject = controller.subjects.isNotEmpty ? controller.subjects[0] : null;

              return selectedSubject != null
                  ? Column(
                children: [
                  TextField(
                    controller: milestoneTitleController,
                    decoration: const InputDecoration(labelText: 'Título del hito'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final DateTime? pickedDateTime = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDateTime != null && pickedDateTime != selectedMilestoneDate) {setState(() {
                        selectedMilestoneDate = pickedDateTime;
                      });
                      }
                    },
                    child: Text(selectedMilestoneDate == null
                        ? 'Seleccionar fecha'
                        : DateFormat('yyyy-MM-dd').format(selectedMilestoneDate!)),
                  ),
                  DropdownButton<Importance>(
                    value: selectedMilestoneImportance,
                    onChanged: (Importance? newValue) {
                      setState(() {
                        selectedMilestoneImportance = newValue!;
                      });
                    },
                    items: Importance.values.map((Importance importance) {
                      return DropdownMenuItem<Importance>(
                        value: importance,
                        child: Text(importance.name),
                      );
                    }).toList(),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (milestoneTitleController.text.isNotEmpty && selectedMilestoneDate != null) {
                        controller.addMilestone(
                          selectedSubject,
                          Milestone(
                            title: milestoneTitleController.text,
                            date: selectedMilestoneDate!,
                            importance: selectedMilestoneImportance,
                          ),
                        );
                        milestoneTitleController.clear();
                        setState(() {
                          selectedMilestoneDate = null;
                          selectedMilestoneImportance = Importance.low;
                        });
                        Get.snackbar('Hito agregado', 'El hito se ha agregado correctamente.');
                      } else {
                        Get.snackbar('Error', 'Por favor, completa todos los campos.');
                      }
                    },
                    child: const Text('Agregar hito'),
                  ),
                  const SizedBox(height: 16),
                  // Lista de hitos del ramo seleccionado
                  Expanded(
                    child: ListView.builder(
                      itemCount: selectedSubject.milestones.length,
                      itemBuilder: (context, index) {
                        final milestone = selectedSubject.milestones[index];
                        return ListTile(
                          title: Text(milestone.title),
                          subtitle: Text(
                              'Fecha: ${DateFormat('yyyy-MM-dd').format(milestone.date)}, Importancia: ${milestone.importance.name}'),
                        );
                      },
                    ),
                  ),
                ],
              )
                  : const Text('Selecciona un ramo para agregar hitos.');
            }),
          ],
        ),
      ),
    );
  }
}