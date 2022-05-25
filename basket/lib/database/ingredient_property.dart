const String tableIngredientProperty = 'ingredientProperties';

class IngredientPropertyFields {
  static final List<String> values = [id, name, calories, barcode];

  static const id = '_id';
  static const name = 'name';
  static const calories = 'calories';
  static const barcode = 'barcode';
}

class IngredientProperty {
  final int? id;
  final String name;
  final double calories;
  final int barcode;

  const IngredientProperty({
    this.id,
    required this.name,
    required this.calories,
    required this.barcode,
  });

  IngredientProperty copy({
    int? id,
    String? name,
    double? calories,
    int? barcode,
  }) =>
      IngredientProperty(
        id: id ?? this.id,
        name: name ?? this.name,
        calories: calories ?? this.calories,
        barcode: barcode ?? this.barcode,
      );

  static IngredientProperty fromJson(Map<String, Object?> json) =>
      IngredientProperty(
        id: json[IngredientPropertyFields.id] as int?,
        name: json[IngredientPropertyFields.name] as String,
        calories: json[IngredientPropertyFields.calories] as double,
        barcode: json[IngredientPropertyFields.barcode] as int,
      );

  Map<String, Object?> toJson() => {
        IngredientPropertyFields.id: id,
        IngredientPropertyFields.name: name,
        IngredientPropertyFields.calories: calories,
        IngredientPropertyFields.barcode: barcode,
      };
}
