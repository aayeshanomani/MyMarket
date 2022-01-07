import 'package:cloud_firestore/cloud_firestore.dart';

class Database{

  Future<bool> checkUsername(String phoneNumber) async {
    final result = await Firestore.instance
        .collection("users")
        .where('phoneNumber', isEqualTo: phoneNumber)
        .getDocuments();
    print(result);
    return result.documents.isEmpty;
  }

  getDocument(String uid) {
    return Firestore.instance
        .collection("users")
        .where('userId', isEqualTo: uid)
        .snapshots();
  }
  
}