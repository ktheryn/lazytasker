import 'package:flutter/material.dart';
import 'tasker.dart';

void main() {
  runApp(Checklist());
}

class Checklist extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.light().copyWith(
          primary: Color(0xFF00ac9c),
        ),
      ),
      home: TaskScreen(String),
    );
  }
}


