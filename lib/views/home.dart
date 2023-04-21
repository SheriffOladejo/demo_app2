import 'package:demo_app2/models/message_adapter.dart';
import 'package:demo_app2/utils/hex_color.dart';
import 'package:demo_app2/utils/methods.dart';
import 'package:demo_app2/views/sms_editor.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                          Navigator.of(context).push(slideLeft(const SMSEditor()));
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
                                "Edit SMS",
                                style: TextStyle(
                                    color: HexColor("#7F38AB"),
                                    fontSize: 14,
                                    fontFamily: 'publicsans-bold'
                                ),
                              ),
                              Container(height: 10,),
                              Text(
                                "Edit and existing message or add new content to it",
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
                      Container(
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
                      )
                    ],
                  ),
                  Container(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
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
                      const SizedBox(
                        width: 155,
                        height: 120,
                      )
                    ],
                  ),
                  Container(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("History", style: TextStyle(color: Colors.black, fontFamily: 'publicsans-bold', fontSize: 16),),
                      Text("See all", style: TextStyle(color: Colors.blue, fontFamily: 'publicsans-regular', fontSize: 10),)
                    ],
                  ),
                  Container(
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
                        return MessageAdapter();
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

}
