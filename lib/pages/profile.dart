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
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Center(child: CircleAvatar(),)),
              ],
            ),
            Row(
              children: [
                Expanded(child: TextField()),
              ],
            ),
            Row(
              children: [
                Expanded(child: TextField()),
              ],
            ),
            Row(
              children: [SizedBox(width: 30,),Text("Твой рост: ", style: TextStyle(fontFamily: "Josko", fontSize: 20)),
                SizedBox(width: 30,),
                Expanded(child: TextField()),
                SizedBox(width: 30,)
              ],
            ),
            Row(
              children: [
                Expanded(child: TextButton(child: Text("Sperma"),onPressed: (){},)),
              ],
            )
          ],
        ),
      ),

    );
  }
}
