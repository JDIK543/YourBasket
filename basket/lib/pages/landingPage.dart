// ignore_for_file: file_names

import 'package:basket/pages/favoritesPage.dart';
import 'package:basket/pages/groceryPage.dart';
import 'package:basket/pages/scannerPage2.dart';
import 'package:flutter/material.dart';

// Page Imports
import 'package:basket/pages/samplePage.dart';
import 'package:basket/pages/pantryPage.dart';
import 'package:basket/pages/recipesPage.dart';
//import 'package:basket/pages/scannerPage.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  static const pages = [
    pantryPage(),
    RecipesPage(),
    BarCodeScanner(),
    GroceryPage(),
    FavoritesPage(),
    SamplePage(),
    SamplePage(),
  ];
  int indexOfCurrentPage = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[indexOfCurrentPage],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.lightGreen,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        currentIndex: indexOfCurrentPage,
        onTap: (int selectedIndex) {
          setState(() {
            indexOfCurrentPage = selectedIndex;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: "Pantry"),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book), label: "Recipes"),
          BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_scanner), label: "Scan"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Groceries"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
        ],
      ),
    );
  }
}
