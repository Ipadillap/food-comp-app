class FoodItem {
  final int id;
  final String name;
  bool compare;

  FoodItem({required this.id, required this.name, required this.compare});

  void changeState() {
    if (compare) {
      compare = false;
    } else {
      compare = true;
    }
  }
}
