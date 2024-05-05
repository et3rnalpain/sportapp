import 'package:flutter/material.dart';
import 'package:sportapp/pages/home.dart';
import 'package:sportapp/pages/food.dart';
import 'package:sportapp/pages/training.dart';
import 'package:sqflite/sqflite.dart';

void main() => runApp(MaterialApp(
  home: homepage()
));

class MainPanel extends StatelessWidget {
  const MainPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


