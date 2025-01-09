import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/subs_screen_list.dart';
import 'package:get/get.dart';


void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Subscription Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: SubscriptionListScreen(),
    );
  }
}
