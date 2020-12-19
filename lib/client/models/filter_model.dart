

class FiltersModel {
  final dynamic course;
  final dynamic branch;
  final dynamic semester;

  FiltersModel({this.course, this.branch, this.semester});

  Map<dynamic, dynamic> toJosn() {
    return {
      "course": course,
      "branch": branch,
      "semester": semester,
    };
  }

  FiltersModel.fromJson(Map<dynamic, dynamic> json)
      : course = json['course'],
        semester = json['branch'],
        branch = json['semester'];
}
