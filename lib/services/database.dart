import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {
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

  getApprovedSellers() {
    return Firestore.instance
        .collection("users")
        .where("type", isEqualTo: "Seller")
        .where("applicant", isEqualTo: false)
        .snapshots();
  }

  void uploadProduct(Map<String, dynamic> data) {
    Firestore.instance
        .collection("products")
        .document()
        .setData(data, merge: true)
        .then((value) {
      print("Prod added.");
    }).catchError((err) {
      print(err.toString());
    });
  }

  getSellerProducts(String uid) {
    return Firestore.instance
        .collection("products")
        .where("uploadedBy", isEqualTo: uid)
        .snapshots();
  }

  deleteProd(String docId) {
    Firestore.instance.collection("products").document(docId).delete();
  }
}
