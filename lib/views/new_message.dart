import 'package:demo_app2/models/contact.dart';
import 'package:demo_app2/utils/methods.dart';
import 'package:demo_app2/views/select_contacts.dart';
import 'package:flutter/material.dart';
import '../utils/hex_color.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:permission_handler/permission_handler.dart';

class NewMessage extends StatefulWidget {

  const NewMessage({Key key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();

}

class _NewMessageState extends State<NewMessage> {

  List<Contact> selectedContact = [];
  List<String> recipients = [];

  bool editable = true;
  bool isLoading = false;

  var numberController = TextEditingController();
  var messageController = TextEditingController();

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
        title: const Text("New message", style: TextStyle(
            color: Colors.black,
            fontFamily: 'publicsans-bold',
            fontSize: 18),
        ),
      ),
      body: isLoading ? loadingPage() : Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 30,
                    alignment: Alignment.center,
                    child: TextField(
                      controller: numberController,
                      minLines: 1,
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintText: "Enter recipient's phone number",
                        hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontFamily: 'publicsans-medium',
                            fontSize: 16),
                        prefixIcon: GestureDetector(
                          onTap: () async {
                            selectedContact = await Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectContacts()));
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
                          child: const Icon(Icons.contact_phone,)
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        )
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
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
      isLoading = true;
    });
    //await _askPermissions(null);
    Map<Permission, PermissionStatus> statuses = await [
      Permission.sms,
      Permission.contacts,
    ].request();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> _askPermissions(String routeName) async {
    PermissionStatus smsStatus = await _getSMSPermission();
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      if (routeName != null) {
        Navigator.of(context).pushNamed(routeName);
      }
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  Future<PermissionStatus> _getSMSPermission() async {
    PermissionStatus permission = await Permission.sms.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar =
      SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> send() async {
    setState(() {
      isLoading = true;
    });
    String message = messageController.text.trim();
    recipients = numberController.text.split(",");
    print("recipeint: " + recipients.toString());
    String result = await sendSMS(message: message, recipients: recipients, sendDirect: true)
        .catchError((onError) {
      print(onError);
    });
    setState(() {
      isLoading = false;
    });
    showToast("Message sent");
    Navigator.pop(context);
    print(result);
  }

}
