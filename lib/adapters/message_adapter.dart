import 'dart:ffi';

import 'package:demo_app2/models/message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageAdapter extends StatelessWidget {

  Message message;

  MessageAdapter({
    this.message,
  });

  @override
  Widget build(BuildContext context) {

    // var date = DateTime.fromMillisecondsSinceEpoch(message.timestamp);
    // var timestamp = DateFormat('E, MMM d y').format(date);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Image.asset("assets/images/user.png",)),
          Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("message.recipientName", style: const TextStyle(color: Colors.black, fontFamily: 'publicsans-bold', fontSize: 12),),
                    Text("timestamp", style: const TextStyle(color: Colors.grey, fontFamily: 'publicsans-regular', fontSize: 8),)
                  ],
                ),
              ),
              Container(height: 8,),
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                child: Text(
                  "message.message",
                  style: const TextStyle(color: Colors.black, fontFamily: 'publicsans-regular', fontSize: 10),
                  maxLines: 7,),
              ),
            ],
          )
        ],
      )
    );
  }
}
