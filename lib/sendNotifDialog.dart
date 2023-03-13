// ignore: file_names
import 'package:flutter/material.dart';
import 'package:its_urgent/home.dart';

// ignore: must_be_immutable
class CustomDialog extends StatefulWidget {
  String contact;
  String token;
  CustomDialog({required this.contact, required this.token, super.key});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(  
      title: const Text("Send Notification"),
      content: SizedBox(
        height: 100,
        child: Column(
          children: [
            Text("Are you sure you want to send a notification to ${widget.contact}?"),
            TextField(  
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Enter your message here"
              ),            
            )
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: (){
             sendNotif(widget.token, _controller.text);
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