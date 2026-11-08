import 'package:flutter/material.dart';
import 'package:money_management/core/constant/app_color.dart';
import 'package:money_management/features/transantion/presentation/screens/bottom_navigation/navigation_pages/home.dart';
import 'package:money_management/features/transantion/presentation/screens/bottom_navigation/navigation_pages/stats.dart';
import 'package:money_management/features/transantion/presentation/screens/bottom_navigation/navigation_pages/transaction.dart';

class MainBottomNavigationScreen extends StatefulWidget {
  const MainBottomNavigationScreen({super.key});

  @override
  State<MainBottomNavigationScreen> createState() =>
      _MainBottomNavigationScreenState();
}

class _MainBottomNavigationScreenState
    extends State<MainBottomNavigationScreen> {
  int _currentIndex = 0;
  List _pages = [HomeScreen(), StatsScreen(), TrasnsactionScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.primary,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Transaction'),
        ],
      ),
    );
  }
}
