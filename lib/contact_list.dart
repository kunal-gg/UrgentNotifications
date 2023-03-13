import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:its_urgent/home.dart';
import 'package:its_urgent/sendNotifDialog.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {

  // defining two variables one is the contact list and the other is the boolean showing the loading state
  List<Contact> contacts = [];
  bool isLoading = true;
  String? token;

  // getting the permission for contacts
  void getContacts() async {
    if(await Permission.contacts.isGranted) {
      fetchContacts();
    }else{
      print("this command ran");
      await Permission.contacts.request();
    }
  }

  // fetching the contacts
  void fetchContacts() async{
    contacts = await ContactsService.getContacts();
    setState(() {
      isLoading = false;
    });
  }

  
  void getUserToken() {
    OneSignal.shared.getDeviceState().then((deviceState) {
      print(deviceState!.userId);
      setState(() {
        token = deviceState.userId;
      });
    });
  }


  // the init state for setting the new state
  @override
  void initState() {
    init();
    getUserToken();
    getContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  
        backgroundColor: Colors.grey[800],
        elevation: 0,
        leading: const Icon(Icons.menu),
        title: const Text("Contacts"),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 10),
          Icon(Icons.more_vert),
          SizedBox(width: 10),
        ],
      ),
      body: Center( 
        child: isLoading ?
        const CircularProgressIndicator()
        : ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index)=> GestureDetector(
            onTap: ()=> showDialog(context: context, builder: (context)=>CustomDialog(token: token!, contact: contacts[index].displayName.toString())),
            child: ListTile(
              tileColor: Colors.grey[300],
              leading: const Icon(Icons.person),
              title: Text(contacts[index].displayName.toString()),
            ),
          ),
        )
      ),
    );
  }
}

void init(){
  OneSignal.shared.setAppId('684fdcc7-0b8c-439c-a654-84424caa4ebb');
  OneSignal.shared.promptUserForPushNotificationPermission()
    .then((accepted)=>{
      print("Accepted permission: $accepted")
    });
}