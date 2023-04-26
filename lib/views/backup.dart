import 'package:demo_app2/adapters/backup_message_adapter.dart';
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
            SecondTab(),
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

  bool selectAll = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckboxListTile(
          title: const Text("Select all", style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontFamily: 'publicsans-bold',
          ),),
          value: selectAll,
          onChanged: (newValue) {
            setState(() {
              selectAll = !selectAll;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
        ),
        Container(height: 10,),
        SizedBox(
          height: MediaQuery.of(context).size.height - 260,
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return const Divider();
            },
            controller: ScrollController(),
            itemCount: 7,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index){
              return BackupMessageAdapter();
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
              Image.asset("assets/images/backup_.png", width: 20, height: 20, color: Colors.white,),
            ],
          ),
        )
      ],
    );
  }

}

class SecondTab extends StatefulWidget {

  const SecondTab({Key key}) : super(key: key);

  @override
  State<SecondTab> createState() => _SecondTabState();

}

class _SecondTabState extends State<SecondTab> {

  bool selectAll = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckboxListTile(
          title: const Text("Select all", style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontFamily: 'publicsans-bold',
          ),),
          value: selectAll,
          onChanged: (newValue) {
            setState(() {
              selectAll = !selectAll;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
        ),
        Container(height: 10,),
        SizedBox(
          height: MediaQuery.of(context).size.height - 260,
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return const Divider();
            },
            controller: ScrollController(),
            itemCount: 7,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index){
              return BackupMessageAdapter();
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
                "Restore",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'publicsans-bold'
                ),
              ),
              Container(width: 10,),
              Image.asset("assets/images/restore.png", width: 20, height: 20, color: Colors.white,),
            ],
          ),
        )
      ],
    );
  }

}



