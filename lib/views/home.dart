import 'dart:io';
import 'dart:math';
import 'package:demo_app2/adapters/message_adapter.dart';
import 'package:demo_app2/models/message.dart';
import 'package:demo_app2/utils/db_helper.dart';
import 'package:demo_app2/utils/hex_color.dart';
import 'package:demo_app2/utils/methods.dart';
import 'package:demo_app2/views/backup.dart';
import 'package:demo_app2/views/new_message.dart';
import 'package:demo_app2/views/sms_editor.dart';
import 'package:flutter/material.dart';
import 'package:demo_app2/models/contact.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';

import 'select_contacts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  final form_key = GlobalKey<FormState>();

  bool is_loading = false;

  var db_helper = DbHelper();

  List<Message> conversations = [];

  List<Contact> selectedContact = [];
  List<String> recipients = [];
  var numberController = TextEditingController();
  var messageController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  String sender = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:is_loading ? loadingPage() : SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                width: MediaQuery.of(context).size.width,
                child: Image.asset("assets/images/home_bg.png",)
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => NewMessage(callback: callback,)));
                          },
                          child: Container(
                            width: 155,
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(16)),
                              border: Border.all(color: HexColor("#7F38AB")),
                            ),
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset("assets/images/sms.png"),
                                Container(height: 5,),
                                Text(
                                  "Send SMS",
                                  style: TextStyle(
                                      color: HexColor("#7F38AB"),
                                      fontSize: 14,
                                      fontFamily: 'publicsans-bold'
                                  ),
                                ),
                                Container(height: 10,),
                                Text(
                                  "Quickly compose and send text messages to contacts",
                                  style: TextStyle(
                                      color: HexColor("#7F38AB"),
                                      fontSize: 8,
                                      fontFamily: 'publicsans-regular'
                                  ),
                                ),
                                Container(height: 10,),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.arrow_forward_rounded, color: HexColor("#7F38AB"),),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (Platform.isIOS) {
                              showCupertinoModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                expand: false,
                                builder: (context) => scheduleMessage(),
                              );
                            }
                            else if (Platform.isAndroid) {
                              showMaterialModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                expand: false,
                                builder: (context) => scheduleMessage(),
                              );
                            }
                          },
                          child: Container(
                            width: 155,
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(16)),
                              border: Border.all(color: HexColor("#C66F45")),
                            ),
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset("assets/images/schedule.png"),
                                Container(height: 5,),
                                Text(
                                  "Schedule message",
                                  style: TextStyle(
                                      color: HexColor("#C66F45"),
                                      fontSize: 14,
                                      fontFamily: 'publicsans-bold'
                                  ),
                                ),
                                Container(height: 10,),
                                Text(
                                  "Schedule message to be sent at a later date",
                                  style: TextStyle(
                                      color: HexColor("#C66F45"),
                                      fontSize: 8,
                                      fontFamily: 'publicsans-regular'
                                  ),
                                ),
                                Container(height: 10,),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.arrow_forward_rounded, color: HexColor("#C66F45"),),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(slideLeft(Backup(callback: callback,)));
                          },
                          child: Container(
                            width: 155,
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(16)),
                              border: Border.all(color: HexColor("#5D8800")),
                            ),
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset("assets/images/backup.png"),
                                Container(height: 5,),
                                Text(
                                  "Backup & restore",
                                  style: TextStyle(
                                      color: HexColor("#5D8800"),
                                      fontSize: 14,
                                      fontFamily: 'publicsans-bold'
                                  ),
                                ),
                                Container(height: 10,),
                                Text(
                                  "Backup your messages and restore whenever",
                                  style: TextStyle(
                                      color: HexColor("#5D8800"),
                                      fontSize: 8,
                                      fontFamily: 'publicsans-regular'
                                  ),
                                ),
                                Container(height: 10,),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.arrow_forward_rounded, color: HexColor("#5D8800"),),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 155,
                          height: 120,
                        )
                      ],
                    ),
                    Container(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("History", style: TextStyle(color: Colors.black, fontFamily: 'publicsans-bold', fontSize: 16),),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(slideLeft(const SMSEditor()));
                          },
                          child: const Text("See all", style: TextStyle(color: Colors.blue, fontFamily: 'publicsans-regular', fontSize: 10),)
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 410,
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        controller: ScrollController(),
                        itemCount: conversations.length,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index){
                          return MessageAdapter(message: conversations[index],);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> callback() async {
    conversations = await db_helper.getConversations();
    conversations.sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  Future<void> init() async {
    setState(() {
      is_loading = true;
    });
    Map<Permission, PermissionStatus> statuses = await [
      Permission.sms,
      Permission.contacts,
    ].request();
    conversations = await db_helper.getConversations();
    conversations.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    sender = await db_helper.getPhone();
    setState(() {
      is_loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Widget scheduleMessage() {
    var date = DateFormat('MMMM dd, yyyy').format(selectedDate);
    final localizations = MaterialLocalizations.of(context);
    final formattedTimeOfDay = localizations.formatTimeOfDay(selectedTime);
    return Form(
      key: form_key,
      child: Container(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
            color: HexColor("#E1F7FE"),
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              )
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(height: 25,),
                const Text("Schedule message", style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'publicsans-regular',
                ),),
                Container(height: 15,),
                const Text("Schedule message to be sent at a later date and time"),
                Container(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        validator: (value) {
                          bool ccMissing = false;
                          List<String> list = value.split(",");
                          for (var i = 0; i < list.length; i++) {
                            if (list[i].substring(0, 1) != "+") {
                              ccMissing = true;
                            }
                          }
                          if (ccMissing) {
                            return "Country code is required";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        controller: numberController,
                        minLines: 1,
                        maxLines: 5,
                        decoration: InputDecoration(
                          prefixIcon: GestureDetector(
                            onTap: () async {
                              selectedContact = await Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectContacts()));
                              numberController.text = "";
                              for (int i = 0; i < selectedContact.length; i++) {
                                if (selectedContact[i].contact.phones.isNotEmpty) {
                                  if (i == selectedContact.length - 1) {
                                    numberController.text += selectedContact[i].contact.phones[0].value;
                                  }
                                  else {
                                    numberController.text += "${selectedContact[i].contact.phones[0].value}, ";
                                  }
                                  recipients.add(selectedContact[i].contact.phones[0].value);
                                }
                              }
                              setState(() {

                              });
                            },
                              child: const Icon(Icons.contact_phone)
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "Recipient phone",
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      alignment: Alignment.center,
                      child: MaterialButton(
                        onPressed: () async {
                          await send();
                        },
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        color: HexColor("#4897FA"),
                        child:
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Send",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'publicsans-bold'
                              ),
                            ),
                            Container(width: 5,),
                            Image.asset("assets/images/send.png", width: 20, height: 20,),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Message is required";
                    }
                    return null;
                  },
                  controller: messageController,
                  minLines: 1,
                  maxLines: 20,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "Type in your message",
                  ),
                ),
                Container(height: 20,),
                InkWell(
                  onTap: () async {
                    final DateTime picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101));
                    if (picked != null && picked != selectedDate) {
                      setState(() {
                        if (picked.millisecondsSinceEpoch > DateTime.now().millisecondsSinceEpoch) {
                          selectedDate = picked;
                        }
                      });
                    }
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_month, size: 24, color: Colors.grey,),
                      Container(width: 15,),
                      Column(
                        children: [
                          const Text("Select date", style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'publicsans-regular',
                            fontSize: 10
                          ),),
                          Container(height: 5,),
                          Text(date, style: const TextStyle(
                              color: Colors.grey,
                              fontFamily: 'publicsans-regular',
                              fontSize: 8
                          ),),
                        ],
                      )
                    ],
                  ),
                ),
                const Divider(color: Colors.blue,),
                Container(height: 10,),
                InkWell(
                  onTap: () async {
                    final TimeOfDay picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now());
                    if (picked != null && picked != selectedTime) {
                      setState(() {
                        selectedTime = picked;
                      });
                    }
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.access_time_rounded, size: 24, color: Colors.grey,),
                      Container(width: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Select time", style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'publicsans-regular',
                              fontSize: 10
                          ),),
                          Container(height: 5,),
                          Text(formattedTimeOfDay, style: const TextStyle(
                              color: Colors.grey,
                              fontFamily: 'publicsans-regular',
                              fontSize: 8
                          ),),
                        ],
                      )
                    ],
                  ),
                ),
                const Divider(color: Colors.blue,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> send() async {
    if (form_key.currentState.validate()) {
      int timestamp = DateTime(selectedDate.year, selectedDate.month, selectedDate.day,
          selectedTime.hour, selectedTime.minute).millisecondsSinceEpoch;
      String message = messageController.text.trim();
      recipients = numberController.text.split(",");
      String name = "";

      if (selectedContact.isNotEmpty) {
        for (var i = 0; i < selectedContact.length; i++) {
          name = selectedContact[i].contact.displayName ?? selectedContact[i].contact.phones[0].value;
          var m = Message(
              id: DateTime.now().millisecondsSinceEpoch,
              text: message,
              recipientName: name,
              recipientNumber: selectedContact[i].contact.phones[0].value,
              timestamp: timestamp,
              sender: sender,
              groupDate: "",
              isSelected: false,
              backup: 'false'
          );
          await db_helper.scheduleMessage(m);
          await db_helper.saveMessage(m);
        }
      }
      else {
        for (var i = 0; i < recipients.length; i++) {
          name = recipients[i];
          var timestamp = DateTime.now().millisecondsSinceEpoch;
          var m = Message(
              id: DateTime.now().millisecondsSinceEpoch,
              text: message,
              recipientName: name,
              recipientNumber: recipients[i],
              timestamp: timestamp,
              sender: sender,
              groupDate: "",
              isSelected: false,
              backup: 'false'
          );
          await db_helper.scheduleMessage(m);
          await db_helper.saveMessage(m);
        }
      }
      showToast("Message scheduled");
      messageController.text = "";
      numberController.text = "";
      selectedTime = TimeOfDay.now();
      selectedDate = DateTime.now();
      conversations = await db_helper.getConversations();
      conversations.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      setState(() {

      });
      Navigator.pop(context);
    }
  }

}
