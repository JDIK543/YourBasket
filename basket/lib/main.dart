import 'package:flutter/material.dart';

// Page Imports
import 'package:basket/pages/landingPage.dart';
// Database Imports
import 'package:basket/database/database_driver.dart';

void main() {
  runApp(const BasketApp());
}

class BasketApp extends StatelessWidget {
  const BasketApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseDriver().addAllDemoRecipes();
    return const MaterialApp(
      title: "Basket",
      home: LandingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

int demoIngredientID = 1;
