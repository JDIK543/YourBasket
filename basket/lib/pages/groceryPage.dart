// ignore_for_file: file_names

import 'dart:ui';

import 'package:flutter/material.dart';
// Routes
import 'package:basket/database/app_database.dart';
import 'package:basket/database/grocery_item.dart';

List<GroceryItem> groceries = [];

class GroceryPage extends StatefulWidget {
  const GroceryPage({Key? key}) : super(key: key);

  @override
  _GroceryPage createState() => _GroceryPage();
}

class _GroceryPage extends State<GroceryPage> {
  @override
  void initState() {
    super.initState();
    refreshGroceries();
  }

  Future refreshGroceries() async {
    groceries = await AppDatabase.instance.readAllGroceries();
    setState(() {});
  }

  String findWhichImageToUse(int index) {
    String groceryName = groceries[index].name;
    String fileFinder = 'assets/images/' + groceryName + '.jpg';
    return fileFinder;
  }

  @override
  Widget build(BuildContext context) {
    refreshGroceries();
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: const Text('Grocery List'),
        centerTitle: true,
        backgroundColor: (Colors.lightGreen),
      ),
      body: ListView.builder(
        itemCount: groceries.length,
        itemBuilder: (context, indexOfGroceryList) {
          return Column(
            children: [
              Card(
                child: Column(
                  children: [
                    SizedBox(height: 1),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            groceries[indexOfGroceryList].name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.black,
                          ),
                          child: Text(
                            'Remove',
                          ),
                          onPressed: () {
                            AppDatabase.instance.deleteGroceryItem(
                                groceries[indexOfGroceryList].id!);
                            setState(
                              () {
                                build(context);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
