import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekut_cu/models/daily_study.dart';
import 'package:dekut_cu/models/devotional.dart';
import 'package:dekut_cu/models/event.dart';
import 'package:dekut_cu/models/inventory.dart';
import 'package:dekut_cu/models/payment.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  static Future<Map<String, dynamic>> getCountAnalytics() async {
    int usersSize = 0;
    int devotionalsSize = 0;
    int paymentsSize = 0;
    int studiesSize = 0;
    int inventorySize = 0;
    await _db.collection('devotionals').get().then((snap) => {
          devotionalsSize = snap.size // will return the collection size
        });
    await _db.collection('inventory').get().then((snap) => {
          devotionalsSize = snap.size // will return the collection size
        });
    await _db.collection('users').get().then((snap) => {
          usersSize = snap.size // will return the collection size
        });
    await _db.collection('payments').get().then((snap) => {
          paymentsSize = snap.size // will return the collection size
        });
    await _db.collection('daily_studies').get().then((snap) => {
          studiesSize = snap.size // will return the collection size
        });

    var countMap = {
      'devotionalCount': devotionalsSize,
      'userCount': usersSize,
      'paymentCount': paymentsSize,
      'studyCount': studiesSize,
      'inventoryCount': inventorySize,
    };
    return countMap;
  }

  static saveDevotional(Devotional devotional) async {
    Map<String, dynamic> devotionalData = {
      "month": devotional.month,
      "title": devotional.title,
      "teaching": devotional.teaching,
    };
    final devotionalRef = _db.collection("devotionals").doc(devotional.title);
    if ((await devotionalRef.get()).exists) {
      await devotionalRef.update({
        "teaching": devotional.teaching,
      });
    } else {
      await _db.collection("devotionals").add(devotionalData);
    }
  }

  static saveDailyStudy(DailyStudy study) async {
    Map<String, dynamic> devotionalData = {
      "title": study.title,
      "date": study.date,
      "verse": study.verse,
      "teaching": study.teaching,
    };
    final devotionalRef = _db.collection("daily_studies").doc(study.title);
    if ((await devotionalRef.get()).exists) {
      await devotionalRef.update({
        "teaching": study.teaching,
      });
    } else {
      await _db.collection("daily_studies").add(devotionalData);
    }
  }

  static savePayment(Payment payment) async {
    Map<String, dynamic> paymentData = {
      "amount": payment.amount,
      "category": payment.category,
      "phone": payment.phoneNumber,
    };
    await _db.collection("payments").add(paymentData);
  }

  static addEvent(Event event) async {
    Map<String, dynamic> eventData = {
      "title": event.title,
      "description": event.description,
      "date": event.date,
      "imageUrl": event.imageUrl,
      "attendees": [],
    };

    await _db.collection("events").doc(event.title).set(eventData);
  }

  static registerForEvent(String title, User user) async {
    Map<String, dynamic> data = {
      "attendees": FieldValue.arrayUnion([user.email]),
    };
    await _db.collection("events").doc(title).update(data);
  }

  static addContact(String name, String phone) async {
    Map<String, dynamic> contactData = {
      "name": name,
      "phone": phone,
    };

    await _db.collection("contacts").doc(name).set(contactData);
  }

  static Future<String> getUserMinistry(String userID) async {
    String ministry;
    await _db.collection('users').doc(userID).get().then((value) {
      ministry = value.data()['ministry'];
    });

    return ministry;
  }

  static addInventory(Inventory inventory) async {
    Map<String, dynamic> inventData = {
      "name": inventory.name,
      "state": inventory.state,
      "quantity": inventory.quantity,
    };

    await _db.collection("inventory").doc(inventory.name).set(inventData);
  }
}
