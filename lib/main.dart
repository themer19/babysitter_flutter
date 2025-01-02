import 'package:app/barrenav/accu.dart';
import 'package:app/barrenav/bar.dart';
import 'package:app/departinterface/premier.dart';
import 'package:app/loginpage/authmaman.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Bar(id: "21"),
    );
  }
}
