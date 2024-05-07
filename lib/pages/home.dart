

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() {
    return _homepageState();
  }
}

class _homepageState extends State<homepage> {
  String? w = "5";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 151, 251, 87),
        title: Center(
          child:
            Text("Цели",
                style: TextStyle(
                fontFamily: "Josko",
                fontSize: 20,
                color: Color.fromARGB(255, 12, 12, 12))
            ),
        )
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('weightdata').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
        {
          List<FlSpot> pts = [];
          double miny=200,maxy=-1;
          double minx=200,maxx=-1;
          for(final obj in snapshot.data!.docs.reversed.toList())
          {
            double x1,y1;
            final values = obj["data"].toString().split(' ');
            x1 = double.parse(values[0]);
            y1 = double.parse(values[1]);

            if(y1 > maxy) maxy = y1;
            if(maxy < 30) maxy = 60;
            if(y1 < miny) miny = y1;

            if(x1 > maxx) maxx =  x1;
            if(maxx < 10) maxx = 10;
            if(x1 < minx) minx =  x1;

            pts.add(FlSpot(x1, y1));
          }
          return SafeArea(
            child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 200,
                    child: Row( children: <Widget>[Expanded(

                        child: Container(
                            height: 400,
                            alignment: Alignment.topCenter,
                            child: LineChart(
                                LineChartData
                                  (
                                    minX: minx,
                                    minY: miny,
                                    maxX: maxx,
                                    maxY: maxy,
                                    lineBarsData: [LineChartBarData(
                                        spots: pts,
                                        isCurved: true
                                    )]
                                )
                            )
                        ))]
                    ),
                  ),
                  Container(margin: EdgeInsets.all(10),child: Row(children: <Widget>[ Expanded(child: ElevatedButton(
                    onPressed: () {
                      showDialog(context: context, builder: (BuildContext context)
                      {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                          ),
                          backgroundColor: Color.fromARGB(255, 246, 242, 242),
                          title: Text('Введите свой вес сегодня:', style: TextStyle(fontFamily: 'Josko'),),
                          actions: [
                            TextField(
                              //keyboardType: TextInputType.number,
                              decoration: InputDecoration(hintText: 'Вес (г)',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromARGB(255, 151, 251, 87), width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromARGB(255, 151, 251, 87), width: 1.0),
                                ),
                              ),
                              onChanged: (String value) { w = value;},
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 7, 0, 0)
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromARGB(255, 151, 251, 87),
                                ),
                                onPressed: () {
                                  DateTime date = DateTime.now();
                                  FirebaseFirestore.instance.collection("weightdata").add(
                                      {"data":"${date.day} $w"});
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Готово",
                                  style: TextStyle(color: Color.fromARGB(255, 18, 18, 18)),
                                )
                            )
                          ],
                        );
                      }
                      );

                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 246, 242, 242)),
                    child: Text("Добавить значение", style: TextStyle(
                        fontFamily: "Josko",
                        fontSize: 20,
                        color: Color.fromARGB(255, 12, 12, 12)
                    ),),
                  ))],),
                  ),

                  Container(
                    height: 50,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Color.fromARGB(255, 246, 242, 242),),

                    child: Row(
                      children: [
                        Expanded(child:Center(child: Container(alignment: Alignment.centerRight,child: Text("Ваш индекс массы тела:", style: TextStyle( fontFamily: "Josko", fontSize: 15, color: Color.fromARGB(255, 12, 12, 12)),)))),
                        Expanded(child:Center(child: Container(alignment: Alignment.center,child: Text("Гавно", style: TextStyle( fontFamily: "Josko", fontSize: 15, color: Color.fromARGB(255, 12, 12, 12)),)))),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,)
                ]
            ),
          );
        },
      )
    );
  }
}
