import 'package:demo_app2/adapters/conversation_message_adapter.dart';
import 'package:demo_app2/models/message.dart';
import 'package:demo_app2/utils/db_helper.dart';
import 'package:demo_app2/utils/hex_color.dart';
import 'package:demo_app2/utils/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
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

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  var timestamp = DateTime.now().millisecondsSinceEpoch;

  var messageController = TextEditingController();

  String sender = "";

  bool isSchedule = false;

  @override
  Widget build(BuildContext context) {

    String title;

    if (widget.message.recipientName == widget.message.recipientNumber) {
      title = widget.message.recipientName;
    }
    else if (widget.message.recipientName.isEmpty) {
      title = widget.message.recipientNumber;
    }
    else if (widget.message.recipientName.isNotEmpty && widget.message.recipientNumber.isNotEmpty) {
      title = "${widget.message.recipientName} \n(${widget.message.recipientNumber})";
    }
    else {
      title = widget.message.recipientName;
    }

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
            Text(title, style: const TextStyle(
            color: Colors.black,
            fontFamily: 'publicsans-bold',
            fontSize: 14),
            softWrap: true,
            ),
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
                onTap: () async {
                  final DateTime pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101));
                  if (pickedDate != null && pickedDate != selectedDate) {
                    final TimeOfDay picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now());
                    if (picked != null && picked != selectedTime) {
                      setState(() {
                        selectedDate = pickedDate;
                        selectedTime = picked;
                        isSchedule = true;
                      });
                    }
                  }
                },
              ),
              SizedBox(
                width: 240,
                child: TextField(
                  controller: messageController,
                  minLines: 1,
                  maxLines: 10,
                  decoration: const InputDecoration(
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
                onTap: () async {
                  await send();
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
    sender = await db_helper.getPhone();
    isSchedule = false;
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
    setState(() {
      is_loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> send() async {
    timestamp = DateTime(selectedDate.year, selectedDate.month, selectedDate.day,
        selectedTime.hour, selectedTime.minute).millisecondsSinceEpoch;
    String message = messageController.text.trim();
    var m = Message(
        id: DateTime.now().millisecondsSinceEpoch,
        text: message,
        recipientName: widget.message.recipientName,
        recipientNumber: widget.message.recipientNumber,
        timestamp: timestamp,
        sender: sender,
        groupDate: "",
        isSelected: false,
        backup: 'false'
    );
    messageController.text = "";
    await db_helper.saveMessage(m);
    if (isSchedule) {
      await db_helper.scheduleMessage(m);
    }
    else {
      await sendSMS(message: message, recipients: [widget.message.recipientNumber], sendDirect: true)
          .catchError((onError) {
        print(onError);
      });
    }
    await init();
  }

}
