import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekut_cu/models/devotional.dart';

class DbHelper {
  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static addDevotional(Devotional devotional) async {
    Map<String, dynamic> devotionalData = {
      "title": devotional.title,
      "teaching": devotional.teaching,
    };

    await _db
        .collection("devotionals")
        .doc(devotional.title)
        .set(devotionalData);
  }
}
