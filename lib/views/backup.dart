import 'package:demo_app2/models/message_adapter.dart';
import 'package:demo_app2/utils/hex_color.dart';
import 'package:flutter/material.dart';

class Backup extends StatefulWidget {
  const Backup({Key key}) : super(key: key);

  @override
  State<Backup> createState() => _BackupState();
}

class _BackupState extends State<Backup> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#4897FA"),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  "Backup",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'publicsans-bold',
                      fontSize: 12),
                ),
              ),
              Tab(
                child: Text(
                  "Restore",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'publicsans-bold',
                      fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            FirstTab(),
            FirstTab(),
          ],
        ),
      ),
    );
  }

}

class FirstTab extends StatefulWidget {

  const FirstTab({Key key}) : super(key: key);

  @override
  State<FirstTab> createState() => _FirstTabState();

}

class _FirstTabState extends State<FirstTab> {

  int radioValue = 0;
  int value = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          RadioListTile(
            title: const Text("Select all",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'publicsans-bold'),
            ),
            value: value,
            groupValue: radioValue,
            onChanged: (value){
              print(value);
              setState(() {
                if (radioValue == 1) {
                  radioValue = 0;
                }
                else {
                  radioValue = value;
                }
              });
            },
          ),
          Container(height: 10,),
          SizedBox(
            height: MediaQuery.of(context).size.height - 270,
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
          ),
          MaterialButton(
            onPressed: () {

            },
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            padding: const EdgeInsets.fromLTRB(70, 10, 70, 10),
            color: HexColor("#4897FA"),
            child:
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Backup",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'publicsans-bold'
                  ),
                ),
                Container(width: 10,),
                Image.asset("assets/images/backup_.png", width: 20, height: 20,),
              ],
            ),
          )
        ],
      ),
    );
  }

}


