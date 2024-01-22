import 'package:flores_assignment7/screens/expenses_list.dart';
import 'package:flutter/material.dart';
 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Color(0xFF001B79),
    );
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        // scaffoldBackgroundColor: Colors.red,
        colorScheme: colorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.onPrimaryContainer,
          foregroundColor: colorScheme.onPrimary,
          elevation: 6,
        ),
        cardTheme: CardTheme(
          color: colorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontWeight: FontWeight.w300,
          ),
          displayLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.onPrimaryContainer,
            foregroundColor: colorScheme.onPrimary,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: ExpensesListScreen(),
    );
  }
}

