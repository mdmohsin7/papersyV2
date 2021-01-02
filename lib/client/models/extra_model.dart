import 'package:cloud_firestore/cloud_firestore.dart';

class Extra {
  final String type;
  final String subject;
  final String units;
  final String uploader;
  final String link;
  final String id;
  final String docId;
  final String size;
  final bool isVerified;
  final DocumentReference ref;

  Extra(
      {this.type,
      this.subject,
      this.units,
      this.ref,
      this.uploader,
      this.link,
      this.id,
      this.docId,
      this.size,
      this.isVerified});

  factory Extra.fromFirestore(DocumentSnapshot doc) {
    var _data = doc.data();
    return Extra(
      id: _data['id'],
      subject: _data['s'],
      link: _data['link'],
      size: _data['si'],
      type: _data['t'],
      units: _data['u'],
      uploader: _data['a'],
      docId: doc.id,
      ref: doc.reference,
      isVerified: _data['isv'],
    );
  }
}
