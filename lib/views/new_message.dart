import 'package:demo_app2/models/contact.dart';
import 'package:demo_app2/models/message.dart';
import 'package:demo_app2/utils/db_helper.dart';
import 'package:demo_app2/utils/methods.dart';
import 'package:demo_app2/views/select_contacts.dart';
import 'package:flutter/material.dart';
import '../utils/hex_color.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:permission_handler/permission_handler.dart';

class NewMessage extends StatefulWidget {

  Function callback;

  NewMessage({
    this.callback,
  });

  @override
  State<NewMessage> createState() => _NewMessageState();

}

class _NewMessageState extends State<NewMessage> {

  List<Contact> selectedContact = [];
  List<String> recipients = [];

  bool editable = true;
  bool isLoading = false;

  final form_key = GlobalKey<FormState>();

  var numberController = TextEditingController();
  var messageController = TextEditingController();

  var db_helper = DbHelper();

  String sender = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: form_key,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () async {
              await widget.callback();
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
                      child: TextFormField(
                        controller: numberController,
                        validator: (value) {
                          bool ccMissing = false;
                          List<String> list = numberController.text.split(",");
                          for (var i = 0; i < list.length; i++) {
                            if (list[i].replaceAll(" ", "").substring(0, 1) != "+") {
                              ccMissing = true;
                            }
                          }
                          if (ccMissing) {
                            return "Country code is required";
                          }
                          else if (value.isEmpty) {
                            return "Select contact";
                          }

                          return null;
                        },
                        minLines: 1,
                        maxLines: 10,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: "Enter recipient's phone number",
                          hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontFamily: 'publicsans-medium',
                              fontSize: 16),
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
                // GestureDetector(
                //
                //   child: Image.asset('assets/images/clock.png'),
                //   onTap: () async {
                //     final DateTime pickedDate = await showDatePicker(
                //         context: context,
                //         initialDate: selectedDate,
                //         firstDate: DateTime.now(),
                //         lastDate: DateTime(2101));
                //     if (pickedDate != null && pickedDate != selectedDate) {
                //       final TimeOfDay picked = await showTimePicker(
                //           context: context,
                //           initialTime: TimeOfDay.now());
                //       if (picked != null && picked != selectedTime) {
                //         setState(() {
                //           selectedDate = pickedDate;
                //           selectedTime = picked;
                //           isSchedule = true;
                //         });
                //       }
                //     }
                //   },
                // ),
                Container(height: 1,),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 100,
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
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
                    if (form_key.currentState.validate()) {
                      await send();
                    }
                  },
                ),
              ],
            ),
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
    sender = await db_helper.getPhone();
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
    String name = "";

    if (selectedContact.isNotEmpty) {
      for (var i = 0; i < selectedContact.length; i++) {
        name = selectedContact[i].contact.displayName ?? selectedContact[i].contact.phones[0].value;
        await sendSMS(message: message, recipients: [selectedContact[i].contact.phones[0].value.replaceAll(" ", "")], sendDirect: true)
            .catchError((onError) {
          print(onError);
        });
        var timestamp = DateTime.now().millisecondsSinceEpoch;
        var m = Message(
            id: timestamp,
            text: message,
            recipientName: name,
            recipientNumber: selectedContact[i].contact.phones[0].value,
            timestamp: timestamp,
            sender: sender,
            groupDate: "",
            isSelected: false,
            backup: 'false'
        );
        await db_helper.saveMessage(m);
      }
    }
    else {
      for (var i = 0; i < recipients.length; i++) {
        name = recipients[i];
        await sendSMS(message: message, recipients: [recipients[i]], sendDirect: true)
            .catchError((onError) {
          print(onError);
        });
        var timestamp = DateTime.now().millisecondsSinceEpoch;
        var m = Message(
          id: timestamp,
          text: message,
          recipientName: name,
          recipientNumber: recipients[i],
          timestamp: timestamp,
          sender: sender,
          groupDate: "",
          isSelected: false,
          backup: 'false'
        );
        await db_helper.saveMessage(m);
      }
    }

    setState(() {
      isLoading = false;
    });
    showToast("Message sent");
    await widget.callback();
    Navigator.pop(context);
  }

}
