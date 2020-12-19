import 'package:cloud_firestore/cloud_firestore.dart';

class Paper {
  final String subject;
  final String year;
  final String download;
  final String uploader;
  final String id;
  final bool isVerified;

  Paper({
    this.isVerified,
    this.id,
    this.subject,
    this.uploader,
    this.year,
    this.download,
  });

  factory Paper.fromFirestore(DocumentSnapshot doc) {
    var _data = doc.data();
    return Paper(
      uploader: _data['a'],
      download: _data['link'],
      year: _data['y'],
      subject: _data['s'],
      id: _data['id'],
      isVerified: _data['isv'],
    );
  }
}
