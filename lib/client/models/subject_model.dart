class Subject {
  final String subjectId;
  final String subjectName;

  const Subject({this.subjectId, this.subjectName});

  factory Subject.fromFirestore(Map<dynamic, dynamic> subject) {
    String sId = subject.keys.first;
    print(sId);
    return Subject(subjectId: sId, subjectName: subject[sId]);
  }
}
