import 'package:flutter/material.dart';

import 'cards_view.dart';
import 'expenses_view.dart';
import 'flights_view.dart';
import 'report_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    ExpensesView(),
    ReportView(),
    FlightsView(),
    CardsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white70,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.list, color: Colors.lightBlueAccent,),
            label: 'List',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart, color: Colors.lightBlueAccent,),
            label: 'Chart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.airplanemode_active, color: Colors.lightBlueAccent,),
            label: 'Viagens',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.credit_card, color: Colors.lightBlueAccent,),
            label: 'Cartão',
          ),
        ],
      ),
    );
  }
}