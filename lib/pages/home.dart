import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 151, 251, 87),
        title: Center(
          child:
            Text("Цели",
                style: TextStyle(
                fontFamily: "Josko",
                fontSize: 20,
                color: Color.fromARGB(255, 12, 12, 12))
            ),
        )
      ),
      body: SafeArea(
        child: TextButton(
          onPressed: () {},
          child: Text("Дима Аверченков"),
        ),

      ),

    );
  }
}
