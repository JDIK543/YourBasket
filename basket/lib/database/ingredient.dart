const String tableIngredients = 'inventory';

class IngredientFields {
  static final List<String> values = [
    id,
    name,
    quantity,
    unit,
    calories,
    barcode,
  ];

  static const id = '_id';
  static const name = 'name';
  static const quantity = 'quantity';
  static const unit = 'unit';
  static const calories = 'calories';
  static const barcode = 'barcode';
}

class Ingredient {
  final int? id;
  final String name;
  final num quantity;
  final String unit;
  final num calories;
  final int barcode;

  const Ingredient({
    this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.calories,
    required this.barcode,
  });

  Ingredient copy({
    int? id,
    String? name,
    num? quantity,
    String? unit,
    num? calories,
    int? barcode,
  }) =>
      Ingredient(
        id: id ?? this.id,
        name: name ?? this.name,
        quantity: quantity ?? this.quantity,
        unit: unit ?? this.unit,
        calories: calories ?? this.calories,
        barcode: barcode ?? this.barcode,
      );

  static Ingredient fromJson(Map<String, Object?> json) => Ingredient(
        id: json[IngredientFields.id] as int?,
        name: json[IngredientFields.name] as String,
        quantity: json[IngredientFields.quantity] as double,
        unit: json[IngredientFields.unit] as String,
        calories: json[IngredientFields.calories] as double,
        barcode: json[IngredientFields.barcode] as int,
      );

  Map<String, Object?> toJson() => {
        IngredientFields.id: id,
        IngredientFields.name: name,
        IngredientFields.quantity: quantity,
        IngredientFields.unit: unit,
        IngredientFields.calories: calories,
        IngredientFields.barcode: barcode,
      };
}
