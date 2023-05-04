import 'package:demo_app2/adapters/message_adapter.dart';
import 'package:demo_app2/models/message.dart';
import 'package:demo_app2/utils/db_helper.dart';
import 'package:flutter/material.dart';

class SMSEditor extends StatefulWidget {
  const SMSEditor({Key key}) : super(key: key);

  @override
  State<SMSEditor> createState() => _SMSEditorState();

}

class _SMSEditorState extends State<SMSEditor> {

  bool is_loading = false;

  var db_helper = DbHelper();

  List<Message> conversations = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
            "SMS Editor",
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'publicsans-bold',
              color: Colors.white,
            ),
          ),
            Container(height: 5,),
            const Text(
            "Edit an existing message or send new message",
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'publicsans-regular',
              color: Colors.white,
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white,),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return const Divider();
          },
          controller: ScrollController(),
          itemCount: conversations.length,
          shrinkWrap: false,
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemBuilder: (context, index){
            return MessageAdapter(
              message: conversations[index],
            );
          },
        ),
      ),
    );
  }

  Future<void> init() async {
    setState(() {
      is_loading = true;
    });
    conversations = await db_helper.getConversations();
    conversations.sort((a, b) => b.timestamp.compareTo(a.timestamp));
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
