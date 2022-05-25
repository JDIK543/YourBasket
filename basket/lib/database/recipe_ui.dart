import 'package:basket/database/recipe.dart';

class RecipeUI {
  final int? id;
  final String name;
  final List<String> ingredients;
  final List<String> instructions;

  const RecipeUI({
    this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
  });

  List<String> getIngredients() {
    return ingredients;
  }

  List<String> getInstructions() {
    return instructions;
  }

  Recipe toRecipe() {
    String ingr = '';
    String inst = '';

    for (int i = 0; i < ingredients.length; i++) {
      if (i == 0) {
        ingr = ingr + ingredients[i];
      } else {
        ingr = ingr + '~' + ingredients[i];
      }
    }
    for (int i = 0; i < instructions.length; i++) {
      if (i == 0) {
        inst = inst + instructions[i];
      } else {
        inst = inst + '~' + instructions[i];
      }
    }

    return Recipe(id: id, name: name, ingredients: ingr, instructions: inst);
  }
}
