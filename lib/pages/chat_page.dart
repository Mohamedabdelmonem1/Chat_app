import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../component/chat_bubble.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController controller = TextEditingController();
  final ScrollController controllerScroll = ScrollController();
  List<Message> messageList = [];

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(kLogo, height: 60),
              const Text(
                "Chat",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  if (state is ChatSuccess) {
                    messageList = state.messages;
                  }
                },
                builder: (context, state) {
                  return ListView.builder(
                    reverse: true,
                    controller: controllerScroll,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return messageList[index].id == email
                          ? ChatBubble(message: messageList[index])
                          : ChatBubble2(message: messageList[index]);
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: controller,
                onFieldSubmitted: (value) {
                  BlocProvider.of<ChatCubit>(context)
                      .sendMessage(message: value, email: email);
                  controller.clear();
                  controllerScroll.animateTo(
                    0,
                    //  controllerScroll.position.maxScrollExtent,
                    duration: const Duration(seconds: 2),
                    curve: Curves.fastOutSlowIn,
                  );
                },
                decoration: InputDecoration(
                  hintText: "Send Message",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    color: kPrimaryColor,
                    onPressed: () {},
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
