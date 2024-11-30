import 'package:get/get.dart';

class Milestone {
  String title;
  DateTime date;
  Importance importance;

  Milestone({required this.title, required this.date, required this.importance});
}

enum Importance { low, medium, high }

class Subject {
  String name;
  List<Milestone> milestones;

  Subject({required this.name, this.milestones = const []});
}

class SubjectController extends GetxController {
  RxList<Subject> subjects = <Subject>[].obs;

  void addSubject(Subject subject) {
    subjects.add(subject);
    update(); // Notifica a los widgets que dependen de subjects
  }

  void addMilestone(Subject subject, Milestone milestone) {
    subject.milestones.add(milestone);
    update(); // Notifica a los widgets que dependen de subjects
  }
}