import 'package:flutter/material.dart';
import 'package:money_management/features/transantion/presentation/provider/transaction_provider.dart';
import 'package:money_management/features/transantion/presentation/screens/bottom_navigation/bottom_navigation.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TransactionProvider()..loadTransaction(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money Management',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MainBottomNavigationScreen(),
    );
  }
}
