import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String author;
  final String college;
  final String subject;
  final String units;
  final String download;
  final String size;
  final String id;
  final bool isVerified;
  final String docId;
  final DocumentReference ref;

  Note(
      {this.isVerified,
      this.id,
      this.docId,
      this.ref,
      this.size,
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
      id: _data['id'],
      isVerified: _data['isv'],
      size: _data['si'],
      docId: doc.id,
      ref: doc.reference,
    );
  }

  Map<dynamic, dynamic> toJosn() {
    return {
      "a": author,
      "link": download,
      "s": subject,
      "c": college,
      'si': size,
      'u': units,
      'isv': false,
    };
  }
}
