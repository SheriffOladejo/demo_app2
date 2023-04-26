import 'package:demo_app2/models/message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BackupMessageAdapter extends StatefulWidget {

  Message message;
  BackupMessageAdapter({this.message});

  @override
  State<BackupMessageAdapter> createState() => _BackupMessageAdapterState();

}

class _BackupMessageAdapterState extends State<BackupMessageAdapter> {

  @override
  Widget build(BuildContext context) {

    // var date = DateTime.fromMillisecondsSinceEpoch(widget.message.timestamp);
    // var timestamp = DateFormat('E, MMM d y').format(date);

    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              value: false,
              onChanged: (newValue) {
                setState(() {
                  widget.message.isSelected = !widget.message.isSelected;
                });
              },
            ),
            Container(
                alignment: Alignment.topLeft,
                child: Image.asset("assets/images/user.png",)),
            Column(
              children: [
                Container(height: 8,),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("widget.message.recipientName", style: const TextStyle(color: Colors.black, fontFamily: 'publicsans-bold', fontSize: 12),),
                      Text("timestamp", style: const TextStyle(color: Colors.grey, fontFamily: 'publicsans-regular', fontSize: 8),)
                    ],
                  ),
                ),
                Container(height: 8,),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 100,
                  child: Text(
                    "widget.message.message widget.message.message widget.message.message widget.message.message widget.message.message widget.message.message"
                        "widget.message.message v widget.message.message widget.message.message widget.message.message widget.message.message widget.message.message",
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
