import 'dart:ui';

class Grocery {
  const Grocery({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
  });

  final String id;
  final String name;
  final int quantity;
  final GroceryCategory category;
}


enum GroceryCategory {
  vegetables('Vegetables', Color.fromARGB(255, 0, 255, 128), true),
  fruit('Fruit', Color.fromARGB(255, 145, 255, 0), true),
  meat('Meat', Color.fromARGB(255, 255, 102, 0), true),
  dairy('Dairy', Color.fromARGB(255, 0, 208, 255), true),
  carbs('Carbs', Color.fromARGB(255, 0, 60, 255), true),
  sweets('Sweets', Color.fromARGB(255, 255, 149, 0), true),
  spices('Spices', Color.fromARGB(255, 255, 187, 0), true),
  convenience('Convenience', Color.fromARGB(255, 191, 0, 255), true),
  hygiene('Hygiene', Color.fromARGB(255, 149, 0, 255), false),
  other('Other', Color.fromARGB(255, 0, 225, 255), false);

  final String label;
  final Color color;
  final bool isEdible;

  const GroceryCategory(this.label, this.color, this.isEdible);
}
