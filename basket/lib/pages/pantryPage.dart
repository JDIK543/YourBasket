// ignore_for_file: file_names, camel_case_types

import 'dart:ui';

import 'package:flutter/material.dart';
// Routes
import 'package:basket/database/app_database.dart';
import 'package:basket/database/ingredient.dart';

late int newQuantity;
late String nameOfItem;
late int quantityOfItem;
late double caloriesOfItem;

class pantryPage extends StatefulWidget {
  const pantryPage({Key? key}) : super(key: key);

  @override
  _pantryPage createState() => _pantryPage();
}

class _pantryPage extends State<pantryPage> {
  List<Ingredient> ingredients = [];
  @override
  void initState() {
    super.initState();
    refreshInventory();
  }

  Future refreshInventory() async {
    ingredients = await AppDatabase.instance.readAllInventory();
    setState(() {});
  }

  String findWhichImageToUse(int index) {
    refreshInventory();
    String inventortyItem = ingredients[index].name;
    String fileFinder = 'assets/images/' + inventortyItem + '.jpg';
    return fileFinder;
  }

  @override
  Widget build(BuildContext context) {
    refreshInventory();
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
          title: const Text('Pantry'),
          centerTitle: true,
          backgroundColor: (Colors.lightGreen)),
      body: ListView.builder(
        itemCount: ingredients.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Card(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Ink.image(
                          image: AssetImage(findWhichImageToUse(index)),
                          child: InkWell(
                            onTap: () {},
                          ),
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    SizedBox(height: 1),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              ingredients[index].name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
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
                            AppDatabase.instance.deleteIngredientInventory(
                                ingredients[index].id!);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const addItemToInventoryManually()));
          build(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        mini: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class addItemToInventoryManually extends StatefulWidget {
  const addItemToInventoryManually({Key? key}) : super(key: key);

  @override
  _addItemToInventoryManually createState() => _addItemToInventoryManually();
}

class _addItemToInventoryManually extends State<addItemToInventoryManually> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Input'),
        backgroundColor: (Colors.lightGreen),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: TextField(
              onChanged: (value) => nameOfItem = value,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Ingredient Name',
                hintStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: TextField(
              onChanged: (value) => quantityOfItem = int.parse(value),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Ingredient Quantity',
                hintStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: TextField(
              onChanged: (value) => caloriesOfItem = double.parse(value),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Ingredient Calories',
                hintStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: ElevatedButton.icon(
        onPressed: () {
          Navigator.pop(context,
              MaterialPageRoute(builder: (context) => const pantryPage()));
          AppDatabase.instance.addIngredientInventory(
            Ingredient(
              name: nameOfItem,
              quantity: quantityOfItem,
              unit: 'grams',
              calories: caloriesOfItem,
              barcode: 6969696,
            ),
          );
        },
        icon: const Icon(Icons.done),
        label: const Text('Done'),
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
        ),
      ),
    );
  }
}
