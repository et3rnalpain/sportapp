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
      body: SafeArea(
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
                          minX: 0,
                          minY: 0,
                          maxX: 50,
                          maxY: 50,
                          lineBarsData: [LineChartBarData(
                              spots: [

                              ],
                              isCurved: true
                          )]
                      )
                  )
              ))]
              ),
            ),
          Container(margin: EdgeInsets.all(10),child: Row(children: <Widget>[ Expanded(child: ElevatedButton(
            onPressed: () {},
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
    )
    );
  }
}
