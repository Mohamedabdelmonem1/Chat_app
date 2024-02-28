class Message {
  final String text;
  final String id;

  Message({required this.text, required this.id});

  factory Message.fromJson(json) {
    return Message(text: json['message'], id: json['id']);
  }
}
