
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart';
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
  double goal = 73;
  double? wes;
  double? index;
  String? indextext;

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
      body: Column(children:
      [
        Row(children: [
          Expanded(child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('weightdata').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData) return Text("no data");
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
                if(x1 < minx) minx =  x1;


                pts.add(FlSpot(x1, y1));
              }

              pts.sort((a,b) => a.x.compareTo(b.x));
              wes = pts[pts.length-1].y;
              if(snapshot.data!.docs.isEmpty) {minx=0; maxx = 31; miny = 30; maxy = 100;}
              if(goal < miny) miny = goal;
              if(goal > maxy) maxy = goal;
              return SafeArea(
                child:  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10,),
                      Container(child: Center(child: Text("Динамика веса", style: TextStyle(fontFamily: 'Josko',fontSize: 18)),),),
                      Container(
                        height: 200,
                        child: Row( children: <Widget>[Expanded(
                            child: Container(
                                padding: EdgeInsets.fromLTRB(0, 20, 37, 0),
                                height: 400,
                                alignment: Alignment.topCenter,
                                child: LineChart(
                                    LineChartData
                                      (
                                        minX: minx,
                                        minY: miny,
                                        maxX: maxx,
                                        maxY: maxy,
                                        titlesData: const FlTitlesData(
                                            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))
                                        ),
                                        lineBarsData: [LineChartBarData(

                                            spots: pts,
                                            show: true,
                                            barWidth: 5,
                                            preventCurveOverShooting: true,
                                            curveSmoothness: 0.5,
                                            belowBarData: BarAreaData(
                                                show: true,
                                                gradient: const LinearGradient(colors:
                                                [
                                                  Color.fromARGB(40, 151, 251, 87),
                                                  Color.fromARGB(40, 198, 255, 55),
                                                  Color.fromARGB(40, 208, 255, 116)
                                                ])
                                              //color: Color.fromARGB(40, 151, 251, 87)
                                            ),
                                            gradient: const LinearGradient(colors:
                                            [
                                              Color.fromARGB(255, 151, 251, 87),
                                              Color.fromARGB(255, 198, 255, 55),
                                              Color.fromARGB(255, 208, 255, 116)
                                            ]),
                                            isCurved: true
                                        ),
                                          LineChartBarData(
                                            spots: [FlSpot(minx, goal), FlSpot(maxx, goal)],
                                            show: true,
                                            barWidth: 3,
                                            gradient: const LinearGradient(colors:
                                            [
                                              Color.fromARGB(255, 151, 251, 87),
                                              Color.fromARGB(255, 198, 255, 55),
                                              Color.fromARGB(255, 208, 255, 116)
                                            ]),
                                          )
                                        ]
                                    )
                                )
                            ))]
                        ),
                      ),
                      Container(margin: EdgeInsets.all(10),child: Row(children: <Widget>[ Expanded(child: TextField(
                        decoration: InputDecoration(hintText: "Введите цель (кг)"),
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onChanged: (String text) {
                          goal = double.parse(text);
                          setState(() {
                            return;
                          });
                        },
                      )),
                        Expanded(child: ElevatedButton(
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
                                    decoration: InputDecoration(hintText: 'Вес (кг)',
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
                              fontSize: 14,
                              color: Color.fromARGB(255, 12, 12, 12)
                          ),),
                        ))])),

                      SizedBox(height: 10,),




                    ]
                ),
              );
            },
          )),

        ]),
        Row(
          children: [
            Expanded(child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("profile").snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return Text("no");
                index = wes!/(double.parse(snapshot.data?.docs[0].get('height'))/100 * double.parse(snapshot.data?.docs[0].get('height'))/100);
                if(index! < 16){ indextext = "Выраженный дефицит";}
                if(index! < 25 && index! >= 16){ indextext = "Норма";}
                if(index! >= 25){ indextext = "Избыток";}

                return SafeArea(
                  child:                       Container(
                    height: 50,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Color.fromARGB(255, 246, 242, 242),),

                    child: Row(
                      children: [
                        Expanded(child:Center(child: Container(alignment: Alignment.centerRight,child: Text("Ваш индекс массы тела:", style: TextStyle( fontFamily: "Josko", fontSize: 15, color: Color.fromARGB(255, 12, 12, 12)),)))),
                        Expanded(child:Center(child: Container(alignment: Alignment.center,child: Text(indextext!, style: TextStyle( fontFamily: "Josko", fontSize: 15, color: Color.fromARGB(255, 12, 12, 12)),)))),
                      ],
                    ),
                  ),
                );
              }))]
        )
        ,

          Container(child: Center(child: Text("Динамика потреблённых калорий", style: TextStyle(fontFamily: 'Josko',fontSize: 18)),),),


        Row(children: [
          Expanded(child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("ccaldata").snapshots(),
              builder: (BuildContext context2, AsyncSnapshot<QuerySnapshot> snapshot2)
          {
            if(!snapshot2.hasData) return Text("No data");
            List<FlSpot> pts2 = [];
            for(double i = 1; i < 31; i++)
            {
              pts2.add(FlSpot(i, 0));
            }
            for(var obj in snapshot2.data!.docs.reversed.toList())
            {
              double s = obj['date'];
              double a = double.parse(obj['ccal']);
              for(var o in pts2)
              {
                double prevccal = o.y;
                double f = o.x;
                if(s == f)
                {
                  pts2.remove(o);
                  pts2.add(FlSpot(s, (prevccal + a)));
                }
              }
            }
            pts2.sort((a,b) => a.x.compareTo(b.x));
            return SafeArea(
              child: Column( children: <Widget>[Container(
                  child: Row( children: [Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 37, 0),
                      height: 300,
                      alignment: Alignment.topCenter,
                      child: LineChart(
                          LineChartData
                            (
                              titlesData: const FlTitlesData(
                                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))
                              ),
                              lineBarsData: [LineChartBarData(
                                  show: true,
                                  spots: pts2,
                                  barWidth: 5,
                                  preventCurveOverShooting: true,
                                  curveSmoothness: 0.5,
                                  belowBarData: BarAreaData(
                                      show: true,
                                      gradient: const LinearGradient(colors:
                                      [
                                        Color.fromARGB(40, 151, 251, 87),
                                        Color.fromARGB(40, 198, 255, 55),
                                        Color.fromARGB(40, 208, 255, 116)
                                      ])
                                    //color: Color.fromARGB(40, 151, 251, 87)
                                  ),
                                  gradient: const LinearGradient(colors:
                                  [
                                    Color.fromARGB(255, 151, 251, 87),
                                    Color.fromARGB(255, 198, 255, 55),
                                    Color.fromARGB(255, 208, 255, 116)
                                  ]),
                                  isCurved: true
                              )
                              ]
                          )
                      )
                  ))]
              ))]),
            );
          }))
        ],)
      ],)
    );
  }
}
