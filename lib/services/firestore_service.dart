import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  /// SAVE TRANSACTION
  Future<void> saveTransaction({
    required String zakatType,
    required double amount,
  }) async {
    final user = FirebaseAuth.instance.currentUser;

    await _db.collection("transactions").add({
      "userId": user?.uid,
      "zakatType": zakatType,
      "amount": amount,
      "status": "pending",
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  /// GET ALL USER TRANSACTIONS
  Stream<QuerySnapshot> getTransactions() {
    final user = FirebaseAuth.instance.currentUser;

    return _db
        .collection("transactions")
        .where("userId", isEqualTo: user?.uid)
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  /// UPDATE TRANSACTION (ADMIN / EDIT)
  Future<void> updateTransaction({
    required String docId,
    required String zakatType,
    required int amount,
  }) async {
    await _db.collection("transactions").doc(docId).update({
      "zakatType": zakatType,
      "amount": amount,
    });
  }

  /// SET STATUS (ADMIN)
  Future<void> setStatus(String docId, String status) async {
    await _db.collection("transactions").doc(docId).update({
      "status": status,
    });
  }

  /// DELETE TRANSACTION
  Future<void> deleteTransaction(String docId) async {
    await _db.collection("transactions").doc(docId).delete();
  }
}
