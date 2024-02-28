import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../model/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  void sendMessage({required String message, required var email}) {
    messages.add({
      'message': message,
      'createdAt': DateTime.now(),
      'id': email,
    });
  }

  void getMessage() {
    messages.orderBy('createdAt', descending: true).snapshots().listen((event) {
      List<Message> messageList = [];
      for (int i = 0; i < event.docs.length; i++) {
        messageList.add(Message.fromJson(event.docs[i]));
      }
      emit(ChatSuccess(messages: messageList));
    });
  }
}
