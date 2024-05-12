import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String name = "undefined", weight = "1", height = "1";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ты', style: TextStyle(fontFamily: "Josko", fontSize: 30)),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 151, 251, 87),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children:[
                SizedBox(height: 20),
              ]
            ),
            Row(
              children: [
                Expanded(child: Center(child: CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('images/chel.jpg'),
                ),)),
              ],
            ),
            Row(
              children: [SizedBox(width: 30,),Text("Твой nickname: ", style: TextStyle(fontFamily: "Josko", fontSize: 20)),
                SizedBox(width: 30,),
                Expanded(child: TextField(
                  onChanged: (text) {
                    setState(() {
                      name = text;
                    });
                  },
                  maxLength: 20,
                )),
                SizedBox(width: 80,)
              ],
            ),
            Row(
              children: [SizedBox(width: 30,),Text("Твой вес: ", style: TextStyle(fontFamily: "Josko", fontSize: 20)),
                SizedBox(width: 30,),
                Expanded(child: TextField(
                  onChanged: (text) {
                    setState(() {
                      weight = text;
                    });
                  },
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                )),
                SizedBox(width: 150,),
                Text(weight)
              ],
            ),
            Row(
              children: [SizedBox(width: 30,),Text("Твой рост: ", style: TextStyle(fontFamily: "Josko", fontSize: 20)),
                SizedBox(width: 30,),
                Expanded(child: TextField(
                  onChanged: (text) {
                    setState(() {
                      height = text;
                    });
                  },
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                )),
                SizedBox(width: 150,)
              ],
            ),
            Row(
              children: [
                Expanded(child: TextButton(child: Text("Sperma"),onPressed: (){

                },)),
              ],
            )
          ],
        ),
      ),

    );
  }
}
