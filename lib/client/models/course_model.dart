import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  final String courseName;
  final List<dynamic> branches;
  final List<dynamic> semesters;
  final List<dynamic> subjects;
  final List<dynamic> colleges;
  final String docId;

  Course(
      {this.courseName,
      this.branches,
      this.semesters,
      this.subjects,
      this.colleges,
      this.docId});

  factory Course.fromFirestore(QueryDocumentSnapshot doc) {
    var _data = doc.data();
    return Course(
      courseName: _data['c'],
      branches: _data['det'],
      semesters: _data['s'],
      colleges: _data['cl'],
      docId: doc.id,
    );
  }
  Course.fromJson(Map<dynamic, dynamic> json)
      : courseName = json['c'],
        branches = json['det'],
        semesters = json['s'],
        subjects = json['s'],
        colleges = json['cl'],
        docId = json['id'];
}
