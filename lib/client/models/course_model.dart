import 'package:cloud_firestore/cloud_firestore.dart';

class CourseModel {
  final String courseName;
  final List<dynamic> branches;
  final List<dynamic> semesters;
  final List<dynamic> subjects;
  final List<dynamic> colleges;

  CourseModel(
      {this.courseName,
      this.branches,
      this.semesters,
      this.subjects,
      this.colleges});

  factory CourseModel.fromFirestore(QueryDocumentSnapshot doc) {
    var _data = doc.data();
    return CourseModel(
        courseName: _data['c'],
        branches: _data['det'],
        semesters: _data['s'],
        colleges: _data['cl']);
  }
  CourseModel.fromJson(Map<dynamic, dynamic> json)
      : courseName = json['c'],
        branches = json['det'],
        semesters = json['s'],
        subjects = json['s'],
        colleges = json['cl'];
}
