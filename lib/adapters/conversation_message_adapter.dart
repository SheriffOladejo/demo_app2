import 'package:demo_app2/models/message.dart';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:intl/intl.dart';

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

    var date = DateTime.fromMillisecondsSinceEpoch(widget.message.timestamp);
    var timestamp = DateFormat('hh:mm a').format(date);

    bool pending = false;
    print(widget.message.timestamp);
    print("${DateTime.now().millisecondsSinceEpoch}");
    if (widget.message.timestamp > DateTime.now().millisecondsSinceEpoch) {
      pending = true;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        BubbleSpecialThree(
          text: widget.message.text,
          color: const Color(0xFF1B97F3),
          tail: widget.last,
          isSender: true,
          sent: true,
          textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                padding: const EdgeInsets.only(right: 5),
                child: Text(timestamp, style: const TextStyle(color: Colors.grey, fontFamily: 'publicsans-regular', fontSize: 10),)
            ),
            pending ? Image.asset('assets/images/clock.png') : Container(),
            Container(width: 10,),
          ],
        )
      ],
    );

  }

}
