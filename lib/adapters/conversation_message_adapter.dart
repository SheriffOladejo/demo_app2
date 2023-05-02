import 'package:demo_app2/models/message.dart';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

class ConversationMessageAdapter extends StatefulWidget {

  Message message;
  bool last;
  ConversationMessageAdapter({this.message, this.last});

  @override
  State<ConversationMessageAdapter> createState() => _ConversationMessageAdapterState();

}

class _ConversationMessageAdapterState extends State<ConversationMessageAdapter> {

  @override
  Widget build(BuildContext context) {
    return BubbleSpecialThree(
      text: widget.message.text,
      color: const Color(0xFF1B97F3),
      tail: widget.last,
      isSender: true,
      sent: true,
      textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16
      ),
    );

  }

}
