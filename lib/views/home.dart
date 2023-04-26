import 'dart:io';

import 'package:demo_app2/models/message_adapter.dart';
import 'package:demo_app2/utils/hex_color.dart';
import 'package:demo_app2/utils/methods.dart';
import 'package:demo_app2/views/backup.dart';
import 'package:demo_app2/views/new_message.dart';
import 'package:demo_app2/views/sms_editor.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
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
                          Navigator.of(context).push(slideLeft(const NewMessage()));
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
                          Navigator.of(context).push(slideLeft(const Backup()));
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
                        child: Text("See all", style: TextStyle(color: Colors.blue, fontFamily: 'publicsans-regular', fontSize: 10),)
                      )
                    ],
                  ),
                  SizedBox(
                    height: 320,
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      controller: ScrollController(),
                      itemCount: 7,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return const MessageAdapter();
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget scheduleMessage() {
    return Container(
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
                    child: TextField(
                      minLines: 1,
                      maxLines: 5,
                      decoration: InputDecoration(
                        prefixIcon: GestureDetector(
                          onTap: () {
                            showToast("message");
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
                      onPressed: () {

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
              TextField(
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
              Row(
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
                      const Text("April 14, 2023", style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'publicsans-regular',
                          fontSize: 8
                      ),),
                    ],
                  )
                ],
              ),
              const Divider(color: Colors.blue,),
              Container(height: 10,),
              Row(
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
                      const Text("11:05 PM", style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'publicsans-regular',
                          fontSize: 8
                      ),),
                    ],
                  )
                ],
              ),
              const Divider(color: Colors.blue,),
            ],
          ),
        ),
      ),
    );
  }

}
