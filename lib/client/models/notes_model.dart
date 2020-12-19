import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String author;
  final String college;
  final String subject;
  final String units;
  final String download;
  final int votes;
  final String id;
  final bool isVerified;

  Note(
      {this.isVerified,
      this.id,
      this.votes,
      this.author,
      this.college,
      this.subject,
      this.units,
      this.download});

  factory Note.fromFirestore(DocumentSnapshot doc) {
    var _data = doc.data();
    return Note(
      author: _data['a'],
      college: _data['c'],
      subject: _data['s'],
      units: _data['u'],
      download: _data['link'],
      votes: _data['v'],
      id: _data['id'],
      isVerified: _data['isv']
    );
  }
}
