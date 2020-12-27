import 'package:cloud_firestore/cloud_firestore.dart';

class Extra {
  final String type;
  final String units;
  final String uploader;
  final String link;
  final String id;
  final String docId;
  final String size;

  Extra(
      {this.type,
      this.units,
      this.uploader,
      this.link,
      this.id,
      this.docId,
      this.size});

  factory Extra.fromFirestore(DocumentSnapshot doc) {
    var _data = doc.data();
    return Extra(
      id: _data['id'],
      link: _data['link'],
      size: _data['size'],
      type: _data['type'],
      units: _data['u'],
      uploader: _data['a'],
      docId: doc.id,
    );
  }
}
