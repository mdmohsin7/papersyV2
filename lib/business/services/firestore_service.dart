import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:papersy/business/enums/update_enums.dart';
import 'package:papersy/client/models/extra_model.dart';
import 'package:papersy/client/models/notes_model.dart';
import 'package:papersy/client/models/papers_model.dart';

class FireStoreService {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<Note>> notesList({Map<dynamic, dynamic> details}) {
    return firestore
        .collection("Notes")
        .doc("${details["course"]}")
        .collection("${details["branch"]}")
        .doc("${details["semester"]}")
        .collection("SEM${details["semester"]}")
        .where("isv", isEqualTo: true)
        .snapshots()
        .map(
          (_ds) => _ds.docs.map((e) => Note.fromFirestore(e)).toList(),
        );
  }

  Stream<List<Paper>> papersList({Map<dynamic, dynamic> details}) {
    return firestore
        .collection("Papers")
        .doc("${details["course"]}")
        .collection("${details["branch"]}")
        .doc("${details["semester"]}")
        .collection("SEM${details["semester"]}")
        .where("isv", isEqualTo: true)
        .snapshots()
        .map(
          (_ps) => _ps.docs.map((_p) => Paper.fromFirestore(_p)).toList(),
        );
  }

  Stream<List<Extra>> extrasList({Map<dynamic, dynamic> details}) {
    return firestore
        .collection("Extras")
        .doc("${details["course"]}")
        .collection("${details["branch"]}")
        .doc("${details["semester"]}")
        .collection("SEM${details["semester"]}")
        .where("isv", isEqualTo: true)
        .snapshots()
        .map(
          (_es) => _es.docs.map((_e) => Extra.fromFirestore(_e)).toList(),
        );
  }

  Future<update> uploadData(
      {Map<dynamic, dynamic> v, Map<String, dynamic> data}) async {
    final Completer<update> completer = Completer<update>();
    await firestore
        .collection("${v["Type"]}")
        .doc("${v["Course"]}")
        .collection("${v["Branch"]}")
        .doc("${v["Semester"]}")
        .collection("SEM${v["Semester"]}")
        .doc()
        .set(data)
        .then((value) {
      return completer.complete(update.success);
    }, onError: (e) {
      return completer.completeError(update.failed, StackTrace.current);
    });
    return completer.future;
  }
}
