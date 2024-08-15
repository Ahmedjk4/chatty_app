import 'package:bloc/bloc.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  List<dynamic> messages = [];
  String roomId = "";
  void getChat(String roomId) {
    try {
      FirestoreService.firestore
          .collection('rooms')
          .doc(roomId)
          .snapshots()
          .listen(
        (doc) {
          messages = (doc.get('messages') as List).reversed.toList();
          this.roomId = roomId;
          emit(ChatSuccess(
            messages: messages,
          ));
        },
      );
    } catch (e) {
      emit(ChatError(err: e.toString()));
    }
  }

  void sendMessage(String message) {
    try {
      FirestoreService.sendMessage(
        msg: message,
        roomId: roomId,
        time: DateTime.now(),
        emailOfSender: FirebaseAuth.instance.currentUser!.email!,
      );
      emit(ChatSuccess(messages: messages));
    } catch (e) {
      emit(ChatError(err: e.toString()));
    }
  }
}
