import 'package:demo_app2/utils/hex_color.dart';
import 'package:demo_app2/utils/methods.dart';
import 'package:demo_app2/views/home.dart';
import 'package:flutter/material.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key key}) : super(key: key);

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();

}

class _GetStartedScreenState extends State<GetStartedScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/amico.png",width: 360, height: 360,),
              Container(height: 15,),
              const Text("Effortlessly manage your messages", style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'publicsans-bold',
                  fontSize: 24,
              ),),
              Container(height: 15,),
              const Text("Send, backup and schedule SMS messages in easy steps", style: TextStyle(
                color: Colors.black,
                fontFamily: 'publicsans-regular',
                fontSize: 16,
              ),),
              const SizedBox(height: 100,),
              Container(
                width: 190,
                margin: const EdgeInsets.only(bottom: 15,),
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(slideLeft(const HomeScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: HexColor("#4897FA"),
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                  ),
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Get started",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'publicsans-bold'
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
