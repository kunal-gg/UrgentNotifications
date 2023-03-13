import 'dart:convert';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String? token;

  @override
  void initState() {
    setDndPolicy();
    init();
    getUserToken();
    super.initState();
  }

  void getUserToken() {
    OneSignal.shared.getDeviceState().then((deviceState) {
      print(deviceState!.userId);
      setState(() {
        token = deviceState.userId;
      });
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: TextButton(onPressed: ()=>{
        sendNotif(token!, "We Fucking made It")
      }, child: const Text("Get User Token"))),
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

void sendNotif(String playerId, String message) async{
  final appId = '684fdcc7-0b8c-439c-a654-84424caa4ebb';
  final restApiKey = 'NmJiOGU1YmUtZTMxYS00ZjgzLTk2MGMtZGFiM2QyNGJjMWM3';

  final url = Uri.parse('https://onesignal.com/api/v1/notifications');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Basic $restApiKey',
  };
  final body = jsonEncode({
    'app_id': appId,
    'include_player_ids': [playerId],
    'contents': {'en': message},
    'data': {'key': 'value'},
  });

  final response = await http.post(url, headers: headers, body: body);
}


void setDndPolicy() async {
  
if (await FlutterDnd.isNotificationPolicyAccessGranted ?? false) {
	await FlutterDnd.setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_PRIORITY); // Turn on DND - All notifications are suppressed.
} else {
	FlutterDnd.gotoPolicySettings();
}
}


