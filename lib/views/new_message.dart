import 'package:flutter/material.dart';

import '../utils/hex_color.dart';

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
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.black,),
        ),
        title: const Text("New message", style: TextStyle(
            color: Colors.black,
            fontFamily: 'publicsans-bold',
            fontSize: 18),
        ),
      ),
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 30,
                    alignment: Alignment.center,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Enter recipient's phone number",
                        hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontFamily: 'publicsans-medium',
                            fontSize: 16),
                        prefixIcon: GestureDetector(
                          onTap: () {

                          },
                          child: const Icon(Icons.contact_phone,)
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        )
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        color: HexColor("#4897FA"),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(70)),
              color: Colors.white
          ),
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Image.asset('assets/images/clock.png'),
                onTap: () {

                },
              ),
              SizedBox(
                width: 240,
                child: TextField(
                  minLines: 1,
                  maxLines: 10,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Type message",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: 'publicsans-regular',
                      )
                  ),
                ),
              ),
              GestureDetector(
                child: Image.asset('assets/images/send_.png'),
                onTap: () {

                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}
