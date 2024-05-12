import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
class UserPage extends StatefulWidget {

  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool enabled = false;
  late TextEditingController controller;
  late TextEditingController controller1;
  late TextEditingController controller2;

  File? image;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller1 = TextEditingController();
    controller2 = TextEditingController();

    controller.addListener(() {
      final isenabled = controller.text.isNotEmpty;

      setState(() {
        enabled = isenabled;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    controller1.dispose();
    controller2.dispose();

    super.dispose();
  }

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
                Expanded(child: Center(child: image != null ? Image.file(image!):
                CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('/images/chel.jpg'),
                ),)),
                ElevatedButton(onPressed: (){_pickImageFromCamera();}, child: Text('gsg'),)
              ],
            ),
            Row(
              children: [SizedBox(width: 30,),Text("Твой nickname: ", style: TextStyle(fontFamily: "Josko", fontSize: 20)),
                SizedBox(width: 30,),
                Expanded(child: TextField(
                  controller: controller,
                  maxLength: 20,
                )),
                SizedBox(width: 30,)
              ],
            ),
            Row(
              children: [SizedBox(width: 30,),Text("Твой рост: ", style: TextStyle(fontFamily: "Josko", fontSize: 20)),
                SizedBox(width: 30,),
                Expanded(child: TextField(
                  controller: controller1,
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                )),
                SizedBox(width: 30,)
              ],
            ),
            Row(
              children: [SizedBox(width: 30,),Text("Твой возраст: ", style: TextStyle(fontFamily: "Josko", fontSize: 20)),
                SizedBox(width: 30,),
                Expanded(child: TextField(
                  controller: controller2,
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                )),
                SizedBox(width: 30,)
              ],
            ),
            Row(
                children:[
                  SizedBox(height: 20),
                ]
            ),
            Row(
              children: [SizedBox(width: 30,),
                Expanded(child: ElevatedButton(child: Text("Принять изменения"),onPressed: enabled ? (){
                  setState(() {
                    enabled = true;
                  });
                } : null,  )),
                SizedBox(width: 30,)
              ],
            )
          ],
        ),
      ),

    );
  }
  Future _pickImageFromCamera() async
  {
    final img = await ImagePicker().pickImage(source: ImageSource.camera);

    if(img == null) return;
    setState(() {
      image = File(img!.path);
    });
  }
}

