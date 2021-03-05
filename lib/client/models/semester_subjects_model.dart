import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:papersy/client/models/subject_model.dart';

class SemesterSubjects {
  final List<Subject> subjects;

  SemesterSubjects({this.subjects});

  factory SemesterSubjects.fromFirestore(DocumentSnapshot doc) {
    var _data = doc.data();
    List<Subject> subjects = [];
    _data['sub'].forEach((k, v) {
      subjects.add(Subject(
        subjectId: k,
        subjectName: v,
      ));
    });
    print("Subjects : ${subjects.last.subjectId}");
    return SemesterSubjects(subjects: subjects);
  }
}
