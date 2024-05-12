import 'package:flutter/material.dart';
import 'package:sportapp/pages/food.dart';
import 'package:sportapp/pages/home.dart';
import 'package:sportapp/pages/training.dart';
import 'package:sportapp/pages/profile.dart';

class navbar extends StatefulWidget {
  const navbar({super.key});

  @override
  State<navbar> createState() => _navbarState();
}

class _navbarState extends State<navbar> {
  int index = 1;
  final screens = [
    profilepage(),
    homepage(),
    trainingpage(),
    foodpage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Color.fromARGB(255, 151, 251, 87) ,
          labelTextStyle: MaterialStateProperty.all(TextStyle(
            fontSize: 13,
            color: Color.fromARGB(255, 12, 12, 12),
            fontFamily: "Josko"
            ),
          )
        ),
        child: NavigationBar(
          backgroundColor: Color.fromARGB(255, 246, 242, 242),
          onDestinationSelected: (index) =>  setState(() => this.index = index),
          selectedIndex: index,
          destinations: [
            NavigationDestination(icon: Icon(Icons.account_box_outlined), label: "Профиль",),
            NavigationDestination(icon: Icon(Icons.accessibility_new), label: "Цели"),
            NavigationDestination(icon: Icon(Icons.sports), label: "Тренировки"),
            NavigationDestination(icon: Icon(Icons.food_bank), label: "Еда"),
          ],
        ),
      )

    );
  }
}
