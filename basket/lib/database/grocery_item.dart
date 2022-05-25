const String tableGrocery = 'groceries';

class GroceryFields {
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

class GroceryItem {
  final int? id;
  final String name;
  final num? quantity;
  final String? unit;
  final num? calories;
  final int? barcode;

  const GroceryItem({
    this.id,
    required this.name,
    this.quantity,
    this.unit,
    this.calories,
    this.barcode,
  });

  GroceryItem copy({
    int? id,
    String? name,
    num? quantity,
    String? unit,
    num? calories,
    int? barcode,
  }) =>
      GroceryItem(
        id: id ?? this.id,
        name: name ?? this.name,
        quantity: quantity ?? this.quantity,
        unit: unit ?? this.unit,
        calories: calories ?? this.calories,
        barcode: barcode ?? this.barcode,
      );

  static GroceryItem fromJson(Map<String, Object?> json) => GroceryItem(
        id: json[GroceryFields.id] as int?,
        name: json[GroceryFields.name] as String,
        quantity: json[GroceryFields.quantity] as double?,
        unit: json[GroceryFields.unit] as String?,
        calories: json[GroceryFields.calories] as double?,
        barcode: json[GroceryFields.barcode] as int?,
      );

  Map<String, Object?> toJson() => {
        GroceryFields.id: id,
        GroceryFields.name: name,
        GroceryFields.quantity: quantity,
        GroceryFields.unit: unit,
        GroceryFields.calories: calories,
        GroceryFields.barcode: barcode,
      };
}
