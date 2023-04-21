import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {

  const NewMessage({Key key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();

}

class _NewMessageState extends State<NewMessage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New message", style: TextStyle(
            color: Colors.black,
            fontFamily: 'publicsans-regular',
            fontSize: 18),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

      ),
    );
  }

}
