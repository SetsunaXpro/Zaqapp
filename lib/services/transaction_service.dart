import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransactionService {
  static String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // =============================
  // SIMPAN TRANSAKSI KE FIRESTORE
  // =============================
  static Future<void> addTransaction({
    required String type, // fitrah / maal
    required double amount,
  }) async {
    if (_uid == null) return;

    await _firestore.collection('transactions').add({
      'userId': _uid,
      'type': type,
      'amount': amount,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // =============================
  // STREAM HISTORY TRANSAKSI
  // =============================
  static Stream<QuerySnapshot> transactionStream() {
    if (_uid == null) {
      return const Stream.empty();
    }

    return _firestore
        .collection('transactions')
        .where('userId', isEqualTo: _uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
