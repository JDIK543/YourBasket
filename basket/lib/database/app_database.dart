import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:basket/database/recipe.dart';
import 'package:basket/database/ingredient.dart';
import 'package:basket/database/ingredient_property.dart';
import 'package:basket/database/recipe_ui.dart';
import 'package:basket/database/grocery_item.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();

  //////////////////////////////////
  //UNUSABLE METHODS AND FUNCTIONS//
  //////////////////////////////////

  //database field
  static Database? _database;

  //constructor
  AppDatabase._init();

  //database connection
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('app_database.db');
    return _database!;
  }

  //initialize database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath!, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const realType = 'REAL NOT NULL';

    await db.execute('''
    CREATE TABLE $tableIngredientProperty (
      ${IngredientPropertyFields.id} $idType,
      ${IngredientPropertyFields.name} $textType,
      ${IngredientPropertyFields.calories} $realType,
      ${IngredientPropertyFields.barcode} $integerType
    )
    ''');

    await db.execute('''
    CREATE TABLE $tableIngredients (
      ${IngredientFields.id} $idType,
      ${IngredientFields.name} $textType,
      ${IngredientFields.quantity} $realType,
      ${IngredientFields.unit} $textType,
      ${IngredientFields.calories} $realType,
      ${IngredientFields.barcode} $integerType
    )
    ''');

    await db.execute('''
    CREATE TABLE $tableRecipes (
      ${RecipeFields.id} $idType,
      ${RecipeFields.name} $textType,
      ${RecipeFields.ingredients} $textType,
      ${RecipeFields.instructions} $textType
    )
    ''');

    await db.execute('''
    CREATE TABLE $tableGrocery (
      ${GroceryFields.id} $idType,
      ${GroceryFields.name} $textType,
      ${GroceryFields.quantity} 'REAL',
      ${GroceryFields.unit} 'TEXT',
      ${GroceryFields.calories} 'REAL',
      ${GroceryFields.barcode} 'INTEGER'
    )
    ''');

    await db.execute('''
    CREATE TABLE $tableFavorites (
      ${RecipeFields.id} $idType,
      ${RecipeFields.name} $textType,
      ${RecipeFields.ingredients} $textType,
      ${RecipeFields.instructions} $textType
    )
    ''');
  }

  ////////////////////////////////
  //USABLE METHODS AND FUNCTIONS//
  ////////////////////////////////

  Future<void> deleteDB({String filePath = 'app_database.db'}) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath!, filePath);

    deleteDatabase(path);
  }

  resetTableIngredientProperties() async {
    final db = await instance.database;

    db.delete(tableIngredientProperty);
  }

  resetTableInventory() async {
    final db = await instance.database;

    db.delete(tableIngredients);
  }

  resetTableRecipes() async {
    final db = await instance.database;

    db.delete(tableRecipes);
  }

  resetTableGroceries() async {
    final db = await instance.database;

    db.delete(tableGrocery);
  }

  resetTableFavorites() async {
    final db = await instance.database;

    db.delete(tableFavorites);
  }

  Future<IngredientProperty> createIngredientProperty(
      IngredientProperty ingredientProperty) async {
    final db = await instance.database;

    final id =
        await db.insert(tableIngredientProperty, ingredientProperty.toJson());
    return ingredientProperty.copy(id: id);
  }

  Future<IngredientProperty> readIngredientPropertyID(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableIngredientProperty,
      columns: IngredientPropertyFields.values,
      where: '${IngredientPropertyFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return IngredientProperty.fromJson(maps.first);
    } else {
      throw Exception('ID $id is not found');
    }
  }

  Future<IngredientProperty> readIngredientPropertyBarcode(int barcode) async {
    final db = await instance.database;

    final maps = await db.query(
      tableIngredientProperty,
      columns: IngredientPropertyFields.values,
      where: '${IngredientPropertyFields.barcode} = ?',
      whereArgs: [barcode],
    );

    if (maps.isNotEmpty) {
      return IngredientProperty.fromJson(maps.first);
    } else {
      throw Exception('BARCODE $barcode is not found');
    }
  }

  Future<List<IngredientProperty>> readAllIngredientProperties() async {
    final db = await instance.database;

    final orderBy = '${IngredientPropertyFields.name} ASC';

    final result = await db.query(tableIngredientProperty, orderBy: orderBy);

    return result.map((json) => IngredientProperty.fromJson(json)).toList();
  }

  Future<int> updateIngredientProperty(
      IngredientProperty ingredientProperty) async {
    final db = await instance.database;

    return db.update(tableIngredientProperty, ingredientProperty.toJson(),
        where: '${IngredientPropertyFields.id} = ?',
        whereArgs: [ingredientProperty.id]);
  }

  Future<int> deleteIngredientProperty(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableIngredientProperty,
      where: '${IngredientPropertyFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<Ingredient> addIngredientInventory(Ingredient ingredient) async {
    final db = await instance.database;

    final id = await db.insert(tableIngredients, ingredient.toJson());
    return ingredient.copy(id: id);
  }

  Future<Ingredient> searchInventoryID(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableIngredients,
      columns: IngredientFields.values,
      where: '${IngredientFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Ingredient.fromJson(maps.first);
    } else {
      throw Exception('ID $id is not found');
    }
  }

  Future<Ingredient> searchInventoryName(String name) async {
    final db = await instance.database;

    final maps = await db.query(
      tableIngredients,
      columns: IngredientFields.values,
      where: '${IngredientFields.name} = ?',
      whereArgs: [name],
    );

    if (maps.isNotEmpty) {
      return Ingredient.fromJson(maps.first);
    } else {
      throw Exception('NAME $name is not found');
    }
  }

  Future<List<Ingredient>> readAllInventory() async {
    final db = await instance.database;

    final orderBy = '${IngredientFields.name} ASC';

    final result = await db.query(tableIngredients, orderBy: orderBy);

    return result.map((json) => Ingredient.fromJson(json)).toList();
  }

  Future<int> updateInventory(Ingredient ingredient) async {
    final db = await instance.database;

    return db.update(tableIngredients, ingredient.toJson(),
        where: '${IngredientFields.id} = ?', whereArgs: [ingredient.id]);
  }

  Future<int> deleteIngredientInventory(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableIngredients,
      where: '${IngredientFields.id} = ?',
      whereArgs: [id],
    );
  }

  RecipeUI recipeParse(Recipe recipe) {
    final ingredients = recipe.getIngredients();
    final instructions = recipe.getInstructions();

    final RecipeUI recipeUI = RecipeUI(
        id: recipe.id,
        name: recipe.name,
        ingredients: ingredients,
        instructions: instructions);

    return recipeUI;
  }

  Future<Recipe> createRecipe(Recipe recipe) async {
    final db = await instance.database;

    final id = await db.insert(tableRecipes, recipe.toJson());
    return recipe.copy(id: id);
  }

  Future<RecipeUI> searchRecipeID(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableRecipes,
      columns: RecipeFields.values,
      where: '${RecipeFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      Recipe recipe = Recipe.fromJson(maps.first);
      return recipeParse(recipe);
    } else {
      throw Exception('ID $id is not found');
    }
  }

  Future<List<RecipeUI>> searchRecipeName(String name) async {
    final db = await instance.database;

    final result = await db.query(
      tableRecipes,
      columns: RecipeFields.values,
      where: '${RecipeFields.name} LIKE ?',
      whereArgs: [name],
    );

    if (result.isNotEmpty) {
      List<Recipe> recipeResult =
          result.map((json) => Recipe.fromJson(json)).toList();
      List<RecipeUI> recipeListUI = [];
      for (var recipe in recipeResult) {
        recipeListUI.add(recipeParse(recipe));
      }
      return recipeListUI;
    } else {
      throw Exception('NAME $name is not found');
    }
  }

  Future<List<RecipeUI>> searchRecipeIngredients(
      List<Ingredient> searchIngredients) async {
    var ingr = <String>[];
    for (final i in searchIngredients) {
      ingr.add(i.name.toLowerCase());
    }
    var list = await readAllRecipes();
    var result = <RecipeUI>[];
    var match = 0;
    for (final recipe in list) {
      for (final ingredient in recipe.ingredients) {
        if (ingr.contains(ingredient.toLowerCase())) {
          match++;
        }
      }
      if (match == recipe.ingredients.length) {
        result.add(recipe);
      }
      match = 0;
    }
    return result;
  }

  Future<List<RecipeUI>> readAllRecipes() async {
    final db = await instance.database;

    final orderBy = '${RecipeFields.name} ASC';
    final result = await db.query(tableRecipes, orderBy: orderBy);

    List<Recipe> recipeResult =
        result.map((json) => Recipe.fromJson(json)).toList();
    List<RecipeUI> recipeListUI = [];
    for (var recipe in recipeResult) {
      recipeListUI.add(recipeParse(recipe));
    }
    return recipeListUI;
  }

  Future<int> updateRecipe(Recipe recipe) async {
    final db = await instance.database;

    return db.update(tableRecipes, recipe.toJson(),
        where: '${RecipeFields.id} = ?', whereArgs: [recipe.id]);
  }

  Future<int> deleteRecipe(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableRecipes,
      where: '${RecipeFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<GroceryItem> addGroceryItem(GroceryItem groceryItem) async {
    final db = await instance.database;

    final id = await db.insert(tableGrocery, groceryItem.toJson());
    return groceryItem.copy(id: id);
  }

  addGroceryList(Recipe recipe) async {
    RecipeUI recipeUI = recipeParse(recipe);
    for (final ingr in recipeUI.ingredients) {
      addGroceryItem(GroceryItem(name: ingr));
    }
  }

  Future<GroceryItem> searchGroceryID(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableGrocery,
      columns: GroceryFields.values,
      where: '${GroceryFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return GroceryItem.fromJson(maps.first);
    } else {
      throw Exception('ID $id is not found');
    }
  }

  Future<List<GroceryItem>> readAllGroceries() async {
    final db = await instance.database;

    final orderBy = '${GroceryFields.name} ASC';

    final result = await db.query(tableGrocery, orderBy: orderBy);

    return result.map((json) => GroceryItem.fromJson(json)).toList();
  }

  Future<int> updateGroceries(GroceryItem groceryItem) async {
    final db = await instance.database;

    return db.update(tableGrocery, groceryItem.toJson(),
        where: '${GroceryFields.id} = ?', whereArgs: [groceryItem.id]);
  }

  Future<int> deleteGroceryItem(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableGrocery,
      where: '${GroceryFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<Recipe> addFavorite(Recipe recipe) async {
    final db = await instance.database;

    final id = await db.insert(tableFavorites, recipe.toJson());
    return recipe.copy(id: id);
  }

  Future<RecipeUI> searchFavoritesID(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableFavorites,
      columns: RecipeFields.values,
      where: '${RecipeFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      Recipe recipe = Recipe.fromJson(maps.first);
      return recipeParse(recipe);
    } else {
      throw Exception('ID $id is not found');
    }
  }

  Future<List<RecipeUI>> searchFavoritesName(String name) async {
    final db = await instance.database;

    final result = await db.query(
      tableFavorites,
      columns: RecipeFields.values,
      where: '${RecipeFields.name} LIKE ?',
      whereArgs: [name],
    );

    if (result.isNotEmpty) {
      List<Recipe> recipeResult =
          result.map((json) => Recipe.fromJson(json)).toList();
      List<RecipeUI> recipeListUI = [];
      for (var recipe in recipeResult) {
        recipeListUI.add(recipeParse(recipe));
      }
      return recipeListUI;
    } else {
      throw Exception('NAME $name is not found');
    }
  }

  Future<List<RecipeUI>> readAllFavorites() async {
    final db = await instance.database;

    final orderBy = '${RecipeFields.name} ASC';
    final result = await db.query(tableFavorites, orderBy: orderBy);

    List<Recipe> recipeResult =
        result.map((json) => Recipe.fromJson(json)).toList();
    List<RecipeUI> recipeListUI = [];
    for (var recipe in recipeResult) {
      recipeListUI.add(recipeParse(recipe));
    }
    return recipeListUI;
  }

  Future<int> updateFavorites(Recipe recipe) async {
    final db = await instance.database;

    return db.update(tableFavorites, recipe.toJson(),
        where: '${RecipeFields.id} = ?', whereArgs: [recipe.id]);
  }

  Future<int> deleteFavorites(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableFavorites,
      where: '${RecipeFields.id} = ?',
      whereArgs: [id],
    );
  }

  //close connection
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
