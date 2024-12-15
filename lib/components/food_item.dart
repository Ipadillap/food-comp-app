class FoodItem {
  final String id;
  final String code;
  final int groupId;
  final int typeId;
  final String commonNameEs;
  final String scientificName;
  final String? subspecies;
  bool compare;

  FoodItem({
    required this.id,
    required this.code,
    required this.groupId,
    required this.typeId,
    required this.commonNameEs,
    required this.scientificName,
    this.subspecies,
    this.compare = false,
  });

  void changeState() {
    compare = !compare;
  }

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'] as String,
      code: json['code'] as String,
      groupId: json['groupId'] as int,
      typeId: json['typeId'] as int,
      commonNameEs: json['commonName']['es'] as String,
      scientificName: json['scientificName'] as String,
      subspecies: json['subspecies'] as String?,
    );
  }
}
