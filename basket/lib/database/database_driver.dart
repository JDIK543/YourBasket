import 'package:basket/database/recipe.dart';
import 'package:basket/database/ingredient.dart';

//Database Imports
import 'package:basket/database/app_database.dart';
import 'package:basket/database/grocery_item.dart';
import 'package:basket/pages/pantryPage.dart';

class DatabaseDriver {
  void addAllDemoRecipes() {
    //AppDatabase.instance.deleteDB();
    AppDatabase.instance.resetTableRecipes();
    AppDatabase.instance.resetTableInventory();
    AppDatabase.instance.resetTableIngredientProperties();
    AppDatabase.instance.resetTableGroceries();
    AppDatabase.instance.resetTableFavorites();
    AppDatabase.instance.readAllFavorites();
    addBeansAndRice();
    addSpaghetti();
    addFriedRice();
    AddIngredientLettuce();
  }

  addBeansAndRice() {
    AppDatabase.instance.createRecipe(const Recipe(
      name: 'Beans and Rice',
      ingredients:
          'vegetable oil~onion~beans~tomatoes~oregano~garlic powder~rice',
      instructions:
          'In large saucepan, heat oil over medium-high.~Add onion, cook and stir until tender.~Add beans, tomatoes, oregano and garlic powder.~Bring to a boil; stir in rice.~Cover; reduce heat and simmer 5 minutes.~Remove from heat; let stand 5 minutes before serving.~',
    ));
  }

  addSpaghetti() {
    AppDatabase.instance.createRecipe(const Recipe(
      name: 'Spaghetti',
      ingredients: 'noodles~salt~ground beef~tomato sauce~basil',
      instructions:
          'To a large pan, add the pasta, cover with 3 cups cold water, optional salt to taste, and boil over high heat until water has absorbed, about 10 minutes, but watch your pasta and cook as needed until al dente.~While pasta boils, brown the ground beef.~To a large skillet, add the ground beef and cook over medium-high heat, breaking up the meat with a spatula as it cooks to ensure even cooking.~After beef has cooked through, add the pasta sauce, stir to combine, and cook for 1 to 2 minutes, or until heated through.~After pasta has cooked for about 10 minutes, or until all the water has been absorbed, add the sauce over the pasta and toss to combine in the skillet or alternatively plate the pasta and add sauce to each individual plate as desired.~Optionally garnish with basil and Parmesan to taste and serve immediately.~Pasta and sauce are best warm and fresh but extra will keep airtight in the fridge for up to 5 days.~',
    ));
  }

  addFriedRice() {
    AppDatabase.instance.createRecipe(const Recipe(
      name: 'Fried Rice',
      ingredients: 'rice~onion~eggs~sesame oil~soy sauce~green onions',
      instructions:
          'Preheat Skillet and turn your skillet to medium high heat and pour sesame oil into the bottom of your skillet and add the onion, peas and carrots.~Fry this until they are tender.~Slide the veggies to the side and pour the beaten eggs onto the other side.~Use a spatula to scramble the eggs.~Mix them together with the veggies.~Add the rice.Combine it with the veggie and egg mixture and pour the soy sauce on top and stir until it is heated throughout.~Garnish with green onions.~',
    ));
  }

  AddIngredientLettuce() {
    AppDatabase.instance.addIngredientInventory(const Ingredient(
      name: 'vegetable oil',
      quantity: 0,
      unit: 'oz',
      calories: 0,
      barcode: 146786,
    ));
    AppDatabase.instance.addIngredientInventory(const Ingredient(
      name: 'onion',
      quantity: 0,
      unit: 'oz',
      calories: 0,
      barcode: 14678,
    ));
    AppDatabase.instance.addIngredientInventory(const Ingredient(
      name: 'tomatoes',
      quantity: 0,
      unit: 'oz',
      calories: 0,
      barcode: 14979,
    ));
    AppDatabase.instance.addIngredientInventory(const Ingredient(
      name: 'oregano',
      quantity: 0,
      unit: 'oz',
      calories: 0,
      barcode: 135535,
    ));
    AppDatabase.instance.addIngredientInventory(const Ingredient(
      name: 'garlic powder',
      quantity: 0,
      unit: 'oz',
      calories: 0,
      barcode: 1567,
    ));
    AppDatabase.instance.addIngredientInventory(const Ingredient(
      name: 'noodles',
      quantity: 0,
      unit: 'oz',
      calories: 0,
      barcode: 68786,
    ));
    AppDatabase.instance.addIngredientInventory(const Ingredient(
      name: 'salt',
      quantity: 0,
      unit: 'oz',
      calories: 0,
      barcode: 1567,
    ));
    AppDatabase.instance.addIngredientInventory(const Ingredient(
      name: 'ground beef',
      quantity: 0,
      unit: 'oz',
      calories: 0,
      barcode: 1453456,
    ));
    AppDatabase.instance.addIngredientInventory(const Ingredient(
      name: 'tomato sauce',
      quantity: 0,
      unit: 'oz',
      calories: 0,
      barcode: 1234,
    ));
    AppDatabase.instance.addIngredientInventory(const Ingredient(
      name: 'basil',
      quantity: 0,
      unit: 'oz',
      calories: 0,
      barcode: 678,
    ));
    AppDatabase.instance.addIngredientInventory(const Ingredient(
      name: 'eggs',
      quantity: 0,
      unit: 'oz',
      calories: 0,
      barcode: 567,
    ));
    AppDatabase.instance.addIngredientInventory(const Ingredient(
      name: 'sesame oil',
      quantity: 0,
      unit: 'oz',
      calories: 0,
      barcode: 234,
    ));
    AppDatabase.instance.addIngredientInventory(const Ingredient(
      name: 'green onions',
      quantity: 0,
      unit: 'oz',
      calories: 0,
      barcode: 456,
    ));
  }
}
