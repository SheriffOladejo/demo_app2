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
        title: const Text("New message", style: TextStyle(
            color: Colors.black,
            fontFamily: 'publicsans-regular',
            fontSize: 18),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(height: 10,),
            Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(10))
              ),
              child: Row(
                children: [
                  const Icon(Icons.phone, color: Colors.black,),
                  Container(width: 5,),
                  TextField(
                    decoration: InputDecoration(
                      prefix: const Icon(Icons.phone, color: Colors.black,),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      )
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
