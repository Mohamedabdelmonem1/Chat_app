import 'package:chat_app/model/message_model.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Text(
          message.text,
          style: const TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class ChatBubble2 extends StatelessWidget {
  const ChatBubble2({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: const BoxDecoration(
          color: Color(0xff006D84),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Text(
          message.text,
          style: const TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
