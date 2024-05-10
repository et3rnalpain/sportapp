import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sportapp/navigationbar.dart';

class trainingpage extends StatefulWidget {
  const trainingpage({super.key});

  @override
  State<trainingpage> createState() => _trainingpageState();
}

class _trainingpageState extends State<trainingpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 242, 242),
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 151, 251, 87),
          title: Center(
            child: Text(
                style: TextStyle(fontFamily: "Josko", color: Color.fromARGB(255, 18, 18, 18), fontSize: 20),
                "Тренировки"
            ),
          )
      ),
        body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('training').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(!snapshot.hasData) return Text('Нет тренировок');
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            padding: const EdgeInsets.all(10.0),
            itemBuilder: (BuildContext ctx, index) {
              return InkWell(
                onTap: () {
                  showDialog(context: context, builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                        backgroundColor: Color.fromARGB(255, 246, 242, 242),
                        title: Align(
                          alignment: Alignment.center,
                          child:Text(
                            snapshot.data?.docs[index].get('name'), 
                            style: TextStyle(
                              fontFamily: 'Josko',
                              color: Color.fromRGBO(18, 18, 18, 1),
                              fontSize: 35,
                            ),
                            
                          ),
                        ),
                        actions: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              snapshot.data!.docs[index].get('description').toString().replaceAll("ent", '\n'),
                              style: TextStyle(
                                fontFamily: 'Josko',
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Image(
                            image: AssetImage('images/' + snapshot.data?.docs[index].get('image') + '.jpg'),
                          ),
                          Image(
                            image: AssetImage('images/' + snapshot.data?.docs[index].get('image') + '.jpg'),
                          ),
                          Image(
                            image: AssetImage('images/' + snapshot.data?.docs[index].get('image') + '.jpg'),
                          ),
                          Image(
                            image: AssetImage('images/' + snapshot.data?.docs[index].get('image') + '.jpg'),
                          ),
                          Image(
                            image: AssetImage('images/' + snapshot.data?.docs[index].get('image') + '.jpg'),
                          ),
                          Image(
                            image: AssetImage('images/' + snapshot.data?.docs[index].get('image') + '.jpg'),
                          ),
                        ],
                    )
                  );
                  }
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape:BoxShape.rectangle,
                    image: DecorationImage(
                      image: AssetImage('images/' + snapshot.data?.docs[index].get('image') + '.jpg'),
                      fit: BoxFit.cover,
                      opacity: 0.8,
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(100, 25, 100, 25),
                    child: SizedBox(
                      height: 50,
                      width: 500,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child:Text(
                                  snapshot.data?.docs[index].get('name'),
                                  style: TextStyle(
                                    fontFamily: 'Josko',
                                    color: Color.fromRGBO(246, 242, 242, 1),
                                    fontSize: 45,
                                  ),

                                ),
                              ),
                              Padding(padding: EdgeInsets.all(10.0)),
                            ],
                        ),
                      ),
                  ),
                ),
              );
            },
    );
    }
    )
    );
  }
}
