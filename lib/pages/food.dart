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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('food').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData) return Text('Нет еды');
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3/ 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,),
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext ctx, index) {
                return Card(
                  color: Color.fromARGB(255, 151, 251, 87),
                  child: SizedBox(
                    width: 300,
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 0,
                          ), //SizedBox
                          Text(
                            snapshot.data?.docs[index].get('name'),
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.green[900],
                              fontWeight: FontWeight.w500,
                            ), //Textstyle
                          ), //Text
                          const SizedBox(
                            height: 2,
                          ), //SizedBox
                          Text(
                            'Ккал: ' + snapshot.data?.docs[index].get('ccal') + '\nБелки: ' + snapshot.data?.docs[index].get('b') + '\nЖиры: ' + snapshot.data?.docs[index].get('j') + '\nУглеводы: ' + snapshot.data?.docs[index].get('u'),
                            style: TextStyle(
                              fontSize: 8.5,
                              color: Color.fromARGB(255, 18, 18, 18),
                            ), //Textstyle
                          ), //Text
                          const SizedBox(
                            height: 1,
                          ), //SizedBox
                          SizedBox(
                            width: 200,
                            height: 35,
                            child: Row(
                              children: [
                                Padding(
                                    padding: EdgeInsets.fromLTRB(40, 0, 0, 0)
                                ),
                                IconButton(
                                  onPressed: (){
                                    showDialog(context: context, builder: (BuildContext context){
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10.0))
                                        ),
                                        backgroundColor: Color.fromARGB(255, 246, 242, 242),
                                        title: Text('Сколько вы съели?', style: TextStyle(fontFamily: 'Josko'),),
                                        actions: [
                                          TextField(
                                            decoration: InputDecoration(hintText: 'Вес (г)',
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
                                            {name = value;},
                                          ),
                                          Padding(
                                              padding: EdgeInsets.fromLTRB(0, 7, 0, 0)
                                          ),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color.fromARGB(255, 151, 251, 87),
                                              ),
                                              onPressed: () {},
                                              child: Text(
                                                "Готово",
                                                style: TextStyle(color: Color.fromARGB(255, 18, 18, 18)),
                                              )
                                          )
                                        ]
                                      );
                                    });
                                  },
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 151, 251, 87))
                                  ),
                                    icon: Icon(Icons.food_bank_outlined)
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 7, 0)
                                ),
                                IconButton(
                                  onPressed: (){
                                    FirebaseFirestore.instance.collection('food').doc(snapshot.data?.docs[index].id).delete();
                                  },
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 151, 251, 87))
                                  ),
                                  icon: Icon(Icons.delete_outline)
                                ),
                              ],
                            )
                          )
                        ],
                      ), //Column
                    ), //Padding
                  ),
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