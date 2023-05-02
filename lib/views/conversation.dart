import 'package:demo_app2/adapters/conversation_message_adapter.dart';
import 'package:demo_app2/models/message.dart';
import 'package:demo_app2/utils/db_helper.dart';
import 'package:demo_app2/utils/hex_color.dart';
import 'package:demo_app2/utils/methods.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class Conversation extends StatefulWidget {

  Message message;

  Conversation({this.message});

  @override
  State<Conversation> createState() => _ConversationState();

}

class _ConversationState extends State<Conversation> {

  List<Message> messageList = [];

  bool is_loading = false;

  var db_helper = DbHelper();

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
          child: const Icon(Icons.arrow_back, color: Colors.black,),
        ),
        title: Row(
          children: [
            Container(
                alignment: Alignment.topLeft,
                child: Image.asset("assets/images/user.png",)),
            Container(width: 10,),
            Text("${widget.message.recipientName} (${widget.message.recipientNumber})", style: const TextStyle(
            color: Colors.black,
            fontFamily: 'publicsans-bold',
            fontSize: 18)),
          ],
        )
      ),
      body: is_loading ? loadingPage() : GroupedListView<Message, String>(
        elements: messageList,
        groupBy: (message) => message.groupDate,
        groupSeparatorBuilder: (String groupByValue) => Text(groupByValue),
        groupComparator: (value1, value2) => value2.compareTo(value1),
        indexedItemBuilder: (context, message, index) {
          bool last = false;
          if (index == messageList.length - 1) {
            last = true;
          }
          return ConversationMessageAdapter(message: messageList[index], last: last,);
        },
        itemComparator: (m1, m2) => m1.timestamp.compareTo(m2.timestamp), // optional
        useStickyGroupSeparators: true, // optional
        floatingHeader: true, // optional
        order: GroupedListOrder.ASC, // optional
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        color: HexColor("#4897FA"),
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(70)),
              color: Colors.white
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Image.asset('assets/images/clock.png'),
                onTap: () {

                },
              ),
              const SizedBox(
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

  Future<void> init() async {
    setState(() {
      is_loading = true;
    });
    messageList = await db_helper.getConversation(widget.message.recipientNumber);
    messageList.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    setState(() {
      is_loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

}
