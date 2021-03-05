import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:papersy/confidential/confidential_data.dart';

class StorageService {
  FirebaseStorage _notesBucket =
      FirebaseStorage.instanceFor(bucket: ConfidentialData.notesBucketRef);
  FirebaseStorage _papersBucket =
      FirebaseStorage.instanceFor(bucket: ConfidentialData.papersBucketRef);
  FirebaseStorage _extrasBucket =
      FirebaseStorage.instanceFor(bucket: ConfidentialData.extrasBucketRef);
  UploadTask task;
  String downloadUrl;
  Future<String> upload({File file, String reference, String type}) async {
    if (type == "Notes") {
      task = _notesBucket.ref(reference).putFile(file);
      await task.whenComplete(() async {
        downloadUrl = await task.snapshot.ref.getDownloadURL();
        print(downloadUrl);
      });
    } else if (type == "Question Papers") {
      task = _papersBucket.ref(reference).putFile(file);
      await task.whenComplete(() async {
        downloadUrl = await task.snapshot.ref.getDownloadURL();
        print(downloadUrl);
      });
    } else {
      task = _extrasBucket.ref(reference).putFile(file);
      await task.whenComplete(() async {
        downloadUrl = await task.snapshot.ref.getDownloadURL();
        print(downloadUrl);
      });
    }
    return downloadUrl;
  }

  Future<bool> cancel() async {
    return await task.cancel();
  }
}
