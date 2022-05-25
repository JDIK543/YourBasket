const String tableRecipes = 'recipes';
const String tableFavorites = 'favorites';

class RecipeFields {
  static final List<String> values = [id, name, ingredients, instructions];

  static const id = '_id';
  static const name = 'name';
  static const ingredients = 'ingredients';
  static const instructions = 'instructions';
}

class Recipe {
  final int? id;
  final String name;
  final String ingredients;
  final String instructions;

  const Recipe({
    this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
  });

  List<String> getIngredients() {
    final ingredients = this.ingredients.split('~');
    return ingredients;
  }

  List<String> getInstructions() {
    final instructions = this.instructions.split('~');
    return instructions;
  }

  Recipe copy({
    int? id,
    String? name,
    String? ingredients,
    String? instructions,
  }) =>
      Recipe(
        id: id ?? this.id,
        name: name ?? this.name,
        ingredients: ingredients ?? this.ingredients,
        instructions: instructions ?? this.instructions,
      );

  static Recipe fromJson(Map<String, Object?> json) => Recipe(
        id: json[RecipeFields.id] as int?,
        name: json[RecipeFields.name] as String,
        ingredients: json[RecipeFields.ingredients] as String,
        instructions: json[RecipeFields.instructions] as String,
      );

  Map<String, Object?> toJson() => {
        RecipeFields.id: id,
        RecipeFields.name: name,
        RecipeFields.ingredients: ingredients,
        RecipeFields.instructions: instructions,
      };
}
