import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
                Expanded(child: Center(child: image != null ? Image.file(image!):
                CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('/images/chel.jpg'),
                ),)),
                ElevatedButton(onPressed: (){_pickImageFromCamera();}, child: Text('gsg'),)
              ],
            ),
            Row(
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('profile').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return const Text('Нет данных');
                    return Row(
                      children: [
                        Text(snapshot.data?.docs[0].get('name'),),
                        Text(snapshot.data?.docs[0].get('weight'),),
                        Text(snapshot.data?.docs[0].get('height'),)
                      ],
                    );
                  }
                ),
              ]
            ),
            Row(
              children: [SizedBox(width: 30,),Text("Твой nickname: ", style: TextStyle(fontFamily: "Josko", fontSize: 20)),
                SizedBox(width: 30,),
                /*Expanded(child: TextField(
                  controller: controller,
                  onChanged: (text) {
                    setState(() {
                      name = text;
                    });
                  },
                  maxLength: 20,
                )),*/
                Text(name, style: TextStyle(fontFamily: "Josko", fontSize: 20)),
                SizedBox(width: 30,)
              ],
            ),
            Row(
              children: [SizedBox(width: 30,),Text("Твой рост: ", style: TextStyle(fontFamily: "Josko", fontSize: 20)),
                SizedBox(width: 30,),
                /*Expanded(child: TextField(
                  controller: controller1,
                  onChanged: (text) {
                    setState(() {
                      weight = text;
                    });
                  },
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                )),*/
                Text(weight, style: TextStyle(fontFamily: "Josko", fontSize: 20)),

                SizedBox(width: 30,),
                SizedBox(width: 150,),
                //Text(weight)
              ],
            ),
            Row(
              children: [SizedBox(width: 30,),Text("Твой возраст: ", style: TextStyle(fontFamily: "Josko", fontSize: 20)),
                SizedBox(width: 30,),
                /*Expanded(child: TextField(
                  controller: controller2,
                  onChanged: (text) {
                    setState(() {
                      height = text;
                    });
                  },
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                )),*/
                Text(height, style: TextStyle(fontFamily: "Josko", fontSize: 20)),

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
                SizedBox(width: 30,),
             // children: [
                Expanded(child: TextButton(child: Text("Sperma"),onPressed: (){
                  FirebaseFirestore.instance.collection("profile").doc('0qGL2B0vE094290kGXPl').update(
                      {
                        'name': name,
                        'weight': weight,
                        'height': height,
                      }
                  );
                },)),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: ()
        {
          showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              title: Text('Изменить параметры'),
              actions: [
                SafeArea(
            child:
                  Column(
              children: [
               Row(
                children:[
                 SizedBox(height: 20),
                ]
             ),


                Row(
                  children: [Text("Твой nickname: ", style: TextStyle(fontFamily: "Josko", fontSize: 20)),
                   Expanded(child: TextField(
                    onChanged: (text) {
                     setState(() {
                    name = text;
                });
                },
                    maxLength: 20,
                  )),

                  ],

                ),
                Row(
                    children: [Text("Твой вес: ", style: TextStyle(fontFamily: "Josko", fontSize: 20)),
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
                    ],

                ),
                  Row(
                      children: [Text("Твой рост: ", style: TextStyle(fontFamily: "Josko", fontSize: 20)),
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
                   ],
                  ),
                  Row(
                  children: [
                    Expanded(child: TextButton(child: Text("Sperma"),onPressed: (){
                      FirebaseFirestore.instance.collection("profile").doc('0qGL2B0vE094290kGXPl').update(
                    {
                        'name': name,
                        'weight': weight,
                        'height': height,
                    }
                    );
                  },)),
                 ],
                   )
               ],
                ),
              ),
              ],

            );
          });
        },
        child: Icon(
          Icons.settings,
          color: Colors.white
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

