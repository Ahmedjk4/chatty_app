import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();
  static final firestore = FirebaseFirestore.instance;

  static Future<void> sendMessage({
    required String msg,
    required String roomId,
    required DateTime time,
    required String emailOfSender,
  }) async {
    Map<String, dynamic> messageMap = {
      'message': msg,
      'time': time,
      'emailOfSender': emailOfSender,
    };

    DocumentReference roomRef = firestore.collection('rooms').doc(roomId);

    await roomRef.set({
      'messages': FieldValue.arrayUnion([messageMap]),
    }, SetOptions(merge: true));
  }
}
