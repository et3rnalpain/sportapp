import 'package:flutter/material.dart';
class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ты'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 151, 251, 87),
      )

    );
  }
}
