// ignore: file_names
import 'package:flutter/material.dart';
import 'package:its_urgent/home.dart';

class CustomDialog extends StatelessWidget {
  String contact;
  String token;
  CustomDialog({required this.contact, required this.token, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(  
      title: const Text("Send Notification"),
      content: Text("Are you sure you want to send a notification to $contact?"),
      actions: [
        TextButton(onPressed: (){
             sendNotif(token, "This is an urgent notification");
              Navigator.pop(context);
            }, 
        child: const Text("Yes")),
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: const Text("No", style: TextStyle(color: Colors.grey),)),
      ],
    );
  }
}