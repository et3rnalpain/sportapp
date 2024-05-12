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


  File? image;

  String name = "undefined", weight = "1", height = "1";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль', style: TextStyle(fontFamily: "Josko", fontSize: 30)),
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
                  backgroundImage: AssetImage('assets/images/chel.jpg'),
                ),)),

              ],
            ),
            Row(
              children: [SizedBox(width: 170,),Center(child:
              ElevatedButton(onPressed: (){_pickImageFromCamera();}, child: Icon(Icons.photo_camera_outlined)))
              ]
            ),
            Row(
              children: [SizedBox(width: 30,),Text("Твоё имя: ", style: TextStyle(fontFamily: "Josko", fontSize: 20)),
                SizedBox(width: 30,),

                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('profile').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if(!snapshot.hasData) return Text("no");
                    return Text(snapshot.data?.docs[0].get('name'), style: TextStyle(fontFamily: "Josko", fontSize: 20));
                  }),

                SizedBox(width: 30,)
              ],
            ),
            Row(
              children: [SizedBox(width: 30,),Text("Твой рост: ", style: TextStyle(fontFamily: "Josko", fontSize: 20)),
                SizedBox(width: 30,),

                StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('profile').snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if(!snapshot.hasData) return Text("no");
                      return Text(snapshot.data?.docs[0].get('height'), style: TextStyle(fontFamily: "Josko", fontSize: 20));
                    }),

                SizedBox(width: 30,),
                SizedBox(width: 150,),
                //Text(weight)
              ],
            ),
            Row(
              children: [SizedBox(width: 30,),Text("Твой возраст: ", style: TextStyle(fontFamily: "Josko", fontSize: 20)),
                SizedBox(width: 30,),
      StreamBuilder(
          stream: FirebaseFirestore.instance.collection('profile').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(!snapshot.hasData) return Text("no");
            return Text(snapshot.data?.docs[0].get('weight'), style: TextStyle(fontFamily: "Josko", fontSize: 20));
          }),

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
                SizedBox(width: 30,),
             // children: [

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
                  children: [Text("Твоё имя: ", style: TextStyle(fontFamily: "Josko", fontSize: 20)),
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
                    children: [Text("Твой рост: ", style: TextStyle(fontFamily: "Josko", fontSize: 20)),
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
                      children: [Text("Твой возраст: ", style: TextStyle(fontFamily: "Josko", fontSize: 20)),
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
                    Expanded(child: TextButton(child: Text("Ок"),onPressed: (){
                      FirebaseFirestore.instance.collection("profile").doc('0qGL2B0vE094290kGXPl').update(
                    {
                        'name': name,
                        'height': weight,
                        'weight': height,
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

