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
            Expanded(
              child: Row( children: <Widget>[Expanded(
                  child: LineChart(
                      LineChartData
                        (
                          minX: 0,
                          minY: 0,
                          maxX: 50,
                          maxY: 50,
                          lineBarsData: [LineChartBarData(
                              spots: [
                                FlSpot(0, 0),
                                FlSpot(10, 15),
                                FlSpot(20, 25),
                                FlSpot(30, 15),
                              ],
                              isCurved: true
                          )]
                      )
                  )
              )]
              ),
            ),
          Container(child: Row(children: <Widget>[ Expanded(child: ElevatedButton(
            onPressed: () {},
            child: Text("Добавить значение", style: TextStyle(
              fontFamily: "Josko",
              fontSize: 20,
              color: Color.fromARGB(255, 12, 12, 12)
            ),),
          ))],),
          )]
        ),
    )
    );
  }
}
