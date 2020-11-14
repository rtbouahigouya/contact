import 'package:contact/CONSTANT/couleur.dart';
import 'package:contact/SCREEN/detailcontact.dart';
import 'package:contact/SCREEN/listcontact.dart';
import 'package:flutter/material.dart';

import 'SCREEN/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: bleu,
      ),
      home: ListContact(), //Home(),
    );
  }
}
