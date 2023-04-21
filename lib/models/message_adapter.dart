import 'package:flutter/material.dart';

class MessageAdapter extends StatelessWidget {
  const MessageAdapter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 80,
            alignment: Alignment.topLeft,
            child: Image.asset("assets/images/user.png",)),
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Gtbank", style: TextStyle(color: Colors.black, fontFamily: 'publicsans-bold', fontSize: 12),),
                    Text("Tue, Apr 14 2023", style: TextStyle(color: Colors.grey, fontFamily: 'publicsans-regular', fontSize: 8),)
                  ],
                ),
              ),
              Container(height: 8,),
              Container(
                width: MediaQuery.of(context).size.width - 100,
                child: const Text(
                  "Heyman lets go to a party the details of the location is 2972 Westheimer Rd. Santa Ana, Illinois 85486. therell be lots of girls and drugs too. were going to get fucked up get ready man",
                  style: TextStyle(color: Colors.black, fontFamily: 'publicsans-regular', fontSize: 10),
                  maxLines: 7,),
              ),
            ],
          )
        ],
      )
    );
  }
}
