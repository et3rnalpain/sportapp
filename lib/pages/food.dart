import 'package:flutter/material.dart';

class foodpage extends StatefulWidget {
  const foodpage({super.key});

  @override
  State<foodpage> createState() => _foodpageState();
}

class _foodpageState extends State<foodpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Color.fromARGB(255, 246, 242, 242),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 151, 251, 87),
          title: Text(
              style: TextStyle(fontFamily: "Josko"),
              "Еда"
          ),
        ),
        body: Container(

        ),

    );
  }
}