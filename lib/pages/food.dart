import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sportapp/navigationbar.dart';


class foodpage extends StatefulWidget {
  const foodpage({super.key});



  @override
  State<foodpage> createState() => _foodpageState();
}

class _foodpageState extends State<foodpage> {
  String? name, ccal,b,j,u;

  @override
  Widget build(BuildContext context) {
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
        body: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Column(
              children: [
                TextButton(onPressed: () {}, child: Text("ЕДА 1"))
              ],
            ),
            Column(
              children: [
                TextButton(onPressed: () {}, child: Text("ЕДА 2"))
              ],
            )],
          )
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
                        hintText: 'Калорийность',
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
                        hintText: 'Белки',
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
                        hintText: 'Жиры',
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
                        hintText: 'Углеводы',
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

                          FirebaseFirestore.instance.collection("food").add(
                            {
                              'name' : name,
                              'ccal' : ccal,
                              'b' : b,
                              'j' : j,
                              'u' : u
                            }
                          );
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