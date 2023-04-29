import 'package:demo_app2/models/message.dart';
import 'package:demo_app2/utils/hex_color.dart';
import 'package:flutter/material.dart';

class ConversationMessageAdapter extends StatefulWidget {

  Message message;
  ConversationMessageAdapter({this.message});

  @override
  State<ConversationMessageAdapter> createState() => _ConversationMessageAdapterState();

}

class _ConversationMessageAdapterState extends State<ConversationMessageAdapter> {

  @override
  Widget build(BuildContext context) {

    String type = "square"; // circle, square, pointy

    if (widget.message.text.length <= 3) {
      type = "circle";
    }
    else if (widget.message.text.length <= 50 || widget.message.text.length % 2 == 1) {
      type = "square";
    }
    else if (widget.message.text.length > 50 || widget.message.text.length % 2 == 0) {
      type = "pointy";
    }

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: 
          type == "circle" ? const BorderRadius.all(Radius.circular(48)) :
          type == "square" ? const BorderRadius.all(Radius.circular(16)) :
          const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16)
          ),
        color: HexColor("#E1E1E1"),
      ),
      child: Text(widget.message.text, style: const TextStyle(
        color: Colors.black,
        fontFamily: 'publicsans-medium',
        fontSize: 12,
      ),),
    );
  }

}
