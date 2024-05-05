import 'dart:html';

import 'package:flutter/material.dart';
import 'package:sportapp/navigationbar.dart';
import 'package:sportapp/pages/home.dart';
import 'package:sportapp/pages/food.dart';
import 'package:sportapp/pages/training.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "XXX",
          appId: "1:798834587248:android:6d861fcd88e46c39f2e6b5",
          messagingSenderId: "798834587248",
          projectId: "sportapp-c6527")
  );

  runApp(MaterialApp(home: MainPanel()));
}
class MainPanel extends StatelessWidget {
  const MainPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: navbar(),
    );
  }
}


