import 'package:flutter/material.dart';
import 'package:sportapp/pages/home.dart';
import 'package:sportapp/pages/food.dart';
import 'package:sportapp/pages/training.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() => runApp(MaterialApp(
  home: foodpage()
));

class MainPanel extends StatelessWidget {
  const MainPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


