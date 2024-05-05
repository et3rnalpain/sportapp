import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  void initfs() async
  {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
  }

  @override
  State<homepage> createState() {
    initfs();
    return _homepageState();
  }
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
