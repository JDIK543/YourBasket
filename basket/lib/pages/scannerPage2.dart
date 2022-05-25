// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:basket/database/app_database.dart';
import 'package:basket/database/ingredient.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:basket/main.dart';

class BarCodeScanner extends StatefulWidget {
  const BarCodeScanner({Key? key}) : super(key: key);

  @override
  BarCodeState createState() => BarCodeState();
}

class BarCodeState extends State<BarCodeScanner> {
  String? itemScanned = "null";
  bool _visibleYesNoButtons = false;
  String inventoryItem = '';

  refreshDisplay() {
    setState(() {});
  }

  void _toggleYesNoButtons() {
    setState(() {
      _visibleYesNoButtons = !_visibleYesNoButtons;
    });
  }

//String fileFinder = 'assets/images/' + inventortyItem + '.jpg';
/*

children: [
                        Ink.image(
                          image: AssetImage(findWhichImageToUse(index)),
                          child: InkWell(
                            onTap: () {},
                          ),
                          height: 300,
                          fit: BoxFit.cover,

*/

  _demoIngredientIDAdd() {
    demoIngredientID = demoIngredientID + 1;
  }

  Future<String> _scanScreen() async {
    String barcodeScanResult;

    barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', ' ', false, ScanMode.BARCODE);
    return barcodeScanResult;
  }

  Future<String> _setItemValueDEMO(demoIngredientID) async {
    switch (demoIngredientID) {
      case 1:
        {
          Timer(const Duration(seconds: 1), () {
            itemScanned = 'soy sauce';
            inventoryItem = 'soy sauce';
            refreshDisplay();
            AppDatabase.instance.addIngredientInventory(const Ingredient(
              name: 'soy sauce',
              quantity: 1,
              unit: '666 grams',
              calories: 5,
              barcode: 000001,
            ));
          });
        }
        break;
      case 2:
        {
          Timer(const Duration(seconds: 1), () {
            itemScanned = 'rice';
            inventoryItem = 'rice';
            refreshDisplay();
            AppDatabase.instance.addIngredientInventory(const Ingredient(
              name: 'rice',
              quantity: 1,
              unit: '2267 grams',
              calories: 164,
              barcode: 000002,
            ));
          });
        }
        break;
      case 3:
        {
          Timer(const Duration(seconds: 1), () {
            itemScanned = 'beans';
            inventoryItem = 'beans';
            refreshDisplay();
            AppDatabase.instance.addIngredientInventory(const Ingredient(
              name: 'beans',
              quantity: 1,
              unit: '958 grams',
              calories: 120,
              barcode: 000003,
            ));
          });
        }
        break;

      default:
        {
          return "Scanner Error ID: 01";
        }
    }
    return "Scanner Error ID: 02";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text('Groceries Scanner'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: 1,
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
                            image: AssetImage(
                                'assets/images/' + inventoryItem + '.jpg'),
                            child: InkWell(
                              onTap: () {},
                            ),
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                      Text(
                        itemScanned == "null"
                            ? 'Select the button below to start scanning Groceries.'
                            : 'Would you like to add $itemScanned to your pantry?',
                        style: const TextStyle(fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                      Visibility(
                          visible: _visibleYesNoButtons,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(7.0),
                                  primary: Colors.white,
                                  textStyle: const TextStyle(fontSize: 20),
                                  backgroundColor: Colors.lightGreen),
                              onPressed: () {
                                _toggleYesNoButtons();
                              },
                              child: Text('Yes'))),
                      Visibility(
                        visible: _visibleYesNoButtons,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(7.0),
                                primary: Colors.white,
                                textStyle: const TextStyle(fontSize: 20),
                                backgroundColor: Colors.lightGreen),
                            onPressed: () {
                              _toggleYesNoButtons();
                            },
                            child: Text('No')),
                      ),
                      /*Visibility(
                          visible: _visibleYesNoButtons,
                          child: Ink.image(
                            image: AssetImage(
                                'assets/images/' + inventoryItem + '.jpg'),
                            child: InkWell(
                              onTap: () {},
                            ),
                            height: 1,
                            fit: BoxFit.scaleDown,
                          )),*/
                    ],
                  ),
                ),
              ],
            );
          }),
      floatingActionButton: ElevatedButton.icon(
        icon: const Icon(Icons.add),
        label: const Text('Start Scan'),
        style: ElevatedButton.styleFrom(primary: Colors.lightGreen),
        onPressed: () {
          _scanScreen();
          _setItemValueDEMO(demoIngredientID);
          _demoIngredientIDAdd();
          Timer(const Duration(seconds: 1), () {
            _toggleYesNoButtons();
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
/*

body: ButtonBar(
        alignment: MainAxisAlignment.center,
        buttonPadding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
        children: [
          Text(
            itemScanned == "null"
                ? 'Select the button below to start scanning Groceries.'
                : 'Scan Result:  $itemScanned',
            style: const TextStyle(fontSize: 22),
            textAlign: TextAlign.center,
          ),
          Visibility(
              visible: _visibleYesNoButtons,
              child: TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(7.0),
                      primary: Colors.white,
                      textStyle: const TextStyle(fontSize: 20),
                      backgroundColor: Colors.lightGreen),
                  onPressed: () {
                    _toggleYesNoButtons();
                  },
                  child: Text('Yes'))),
          Visibility(
            visible: _visibleYesNoButtons,
            child: TextButton(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(7.0),
                    primary: Colors.white,
                    textStyle: const TextStyle(fontSize: 20),
                    backgroundColor: Colors.lightGreen),
                onPressed: () {
                  _toggleYesNoButtons();
                },
                child: Text('No')),
          ),
          Visibility(
              visible: _visibleYesNoButtons,
              child: Ink.image(
                image: AssetImage('assets/images/' + inventoryItem + '.jpg'),
                child: InkWell(
                  onTap: () {},
                ),
                height: 1,
                fit: BoxFit.scaleDown,
              )),
        ],
      ),
      floatingActionButton: ElevatedButton.icon(
        icon: const Icon(Icons.add),
        label: const Text('Start Scan'),
        style: ElevatedButton.styleFrom(primary: Colors.lightGreen),
        onPressed: () {
          _scanScreen();
          _setItemValueDEMO(demoIngredientID);
          _demoIngredientIDAdd();
          Timer(const Duration(seconds: 1), () {
            _toggleYesNoButtons();
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );

    */