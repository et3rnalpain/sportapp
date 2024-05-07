import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sportapp/navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';


class foodpage extends StatefulWidget {
  const foodpage({super.key});



  @override
  State<foodpage> createState() => _foodpageState();
}

class _foodpageState extends State<foodpage> {
  XFile? _image;
  String? name, ccal,b,j,u;

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      ImagePicker picker = ImagePicker();
      var image = await picker.pickImage(source: ImageSource.camera);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });
    }

    Future uploadPic(BuildContext context) async{
      String fileName = basename(_image?.path ?? 'default');
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("image1" + DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(File(_image?.path ?? 'default'));
      uploadTask.then((res) {
        res.ref.getDownloadURL();
      });
    }
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 246, 242, 242),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 151, 251, 87),
          title: Center(
          child: Text(
              style: TextStyle(fontFamily: "Josko", color: Color.fromARGB(255, 18, 18, 18), fontSize: 20),
              "Еда"
          ),
          )
        ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('food').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData) return
            Center( child: Text ('Нет еды'));
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 5.0,
              ),
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext ctx, index) {
                return Card(
                    elevation: 4.0,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(snapshot.data?.docs[index].get('name')),
                          subtitle: Text('Ккал: ' + snapshot.data?.docs[index].get('ccal') + ' Белки: ' + snapshot.data?.docs[index].get('b') + '\nЖиры: ' + snapshot.data?.docs[index].get('j') + ' Углеводы: ' + snapshot.data?.docs[index].get('u')),
                        ),
                        Padding(padding:EdgeInsets.fromLTRB(0, 20, 0, 0)),
                        Container(
                          height: 200,
                          width: 300,
                          decoration: BoxDecoration(
                              shape:BoxShape.rectangle,
                              image: DecorationImage(
                                image: AssetImage('images/grecha.jpg'),
                                fit: BoxFit.cover,
                                opacity: 1,
                              )
                          ),
                        ),
                        ButtonBar(
                          children: [
                            IconButton(
                              icon: Icon(Icons.camera),
                              onPressed: () {getImage(); uploadPic(context);},
                            ),
                            IconButton(
                              icon: Icon(Icons.food_bank_outlined),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(Icons.delete_outline_outlined),
                              onPressed: () {},
                            )
                          ],
                        )
                      ],
                    )
                );
              });
        },

      ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 151, 251, 87),
        onPressed: () {
            showDialog(context: context, builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                  backgroundColor: Color.fromARGB(255, 246, 242, 242),
                  title: Text('Добавить еду', style: TextStyle(fontFamily: 'Josko'),),
                  actions: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Название',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 151, 251, 87), width: 5.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 151, 251, 87), width: 1.0),
                        ),
                      ),
                      onChanged: (String value)
                      {
                        name = value;
                      },
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0)
                    ),
                    TextField(
                      maxLength: 3,
                      decoration: InputDecoration(
                        hintText: 'Калорийность (на 100г)',
                        counterText: '',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 151, 251, 87), width: 5.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 151, 251, 87), width: 1.0),
                        ),
                      ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                      onChanged: (String value)
                    {
                      ccal = value;
                    },
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0)
                    ),
                    TextField(
                      maxLength: 3,
                      decoration: InputDecoration(
                        hintText: 'Белки (на 100г)',
                        counterText: '',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 151, 251, 87), width: 5.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 151, 251, 87), width: 1.0),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],onChanged: (String value)
                    {
                      b = value;
                    },
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0)
                    ),
                    TextField(
                      maxLength: 3,
                      decoration: InputDecoration(
                        hintText: 'Жиры (на 100г)',
                        counterText: '',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 151, 251, 87), width: 5.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 151, 251, 87), width: 1.0),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],onChanged: (String value)
                    {
                      j = value;
                    },
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0)
                    ),
                    TextField(
                      maxLength: 3,
                      decoration: InputDecoration(
                        hintText: 'Углеводы (на 100г)',
                        counterText: '',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 151, 251, 87), width: 5.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 151, 251, 87), width: 1.0),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],onChanged: (String value)
                    {
                      u = value;
                    },
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 10, 5)
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 151, 251, 87),
                        ),
                        onPressed: ()
                        {
                          if(name != null && ccal != null && b != null && j != null && u != null)
                            {
                              FirebaseFirestore.instance.collection("food").add(
                                  {
                                    'name' : name,
                                    'ccal' : ccal,
                                    'b' : b,
                                    'j' : j,
                                    'u' : u
                                  }
                              );
                              Navigator.of(context).pop();
                            }
                          else
                            {
                              Navigator.of(context).pop();
                              showDialog(context: context, builder: (BuildContext context){
                                return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                                    ),
                                    backgroundColor: Color.fromARGB(255, 246, 242, 242),
                                    title: Text('Вы не ввели необходимые параметры', style: TextStyle(fontFamily: 'Josko', fontSize: 20), ),
                                    actions: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color.fromARGB(255, 151, 251, 87),
                                          ),
                                          onPressed: () { Navigator.of(context).pop(); },
                                          child: Text(
                                            "Ок",
                                            style: TextStyle(color: Color.fromARGB(255, 18, 18, 18)),
                                          )
                                      )
                                    ]
                                );
                              });
                            }

                        },
                        child: Text(
                            "Добавить",
                          style: TextStyle(color: Color.fromARGB(255, 18, 18, 18)),
                        )
                    )

                  ],
                );
            });
        },
        child: Icon(
          Icons.add,
          color: Color.fromARGB(255, 18, 18, 18),
        ),

    ),



    );
  }
}