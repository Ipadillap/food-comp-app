class FoodItemDetails {
  final String id;
  final String code;
  final String? strain;
  final String? brand;
  final String? observation;
  final Group group;
  final Type type;
  final String? scientificName;
  final String? subspecies;
  final String? commonName;
  final String? ingredients;
  final NutrientMeasurements nutrientMeasurements;
  final List<Origin>? origins;
  final List<LangualCode> langualCodes;
  final List<Reference> references;

  FoodItemDetails({
    required this.id,
    required this.code,
    this.strain,
    this.brand,
    this.observation,
    required this.group,
    required this.type,
    this.scientificName,
    this.subspecies,
    this.commonName,
    this.ingredients,
    required this.nutrientMeasurements,
    this.origins,
    required this.langualCodes,
    required this.references,
  });

  factory FoodItemDetails.fromJson(Map<String, dynamic> json) {
    return FoodItemDetails(
      id: json['id'] as String,
      code: json['code'] as String,
      strain: json['strain'] as String?,
      brand: json['brand'] as String?,
      observation: json['observation'] as String?,
      group: Group.fromJson(json['group']),
      type: Type.fromJson(json['type']),
      scientificName: json['scientificName'] as String?,
      subspecies: json['subspecies'] as String?,
      commonName: json['commonName']?['es'],
      ingredients: json['ingredients']?['es'],
      nutrientMeasurements:
      NutrientMeasurements.fromJson(json['nutrientMeasurements']),
      origins: json['origins'] != null
          ? (json['origins'] as List)
          .map((e) => Origin.fromJson(e))
          .toList()
          : null,
      langualCodes: (json['langualCodes'] as List)
          .map((e) => LangualCode.fromJson(e))
          .toList(),
      references: (json['references'] as List)
          .map((e) => Reference.fromJson(e))
          .toList(),
    );
  }

  void Verification() {
    print("=== Food Item Details ===");
    print("ID: $id");
    print("Code: $code");
    print("Strain: ${strain ?? 'N/A'}");
    print("Brand: ${brand ?? 'N/A'}");
    print("Observation: ${observation ?? 'N/A'}");
    print("Group: ${group.name} (${group.code})");
    print("Type: ${type.name} (${type.code})");
    print("Scientific Name: ${scientificName ?? 'N/A'}");
    print("Subspecies: ${subspecies ?? 'N/A'}");
    print("Common Name (ES): ${commonName ?? 'N/A'}");
    print("Ingredients (ES): ${ingredients ?? 'N/A'}");

    print("\n=== Nutrient Measurements ===");

    print("Energy:");
    for (var energyItem in nutrientMeasurements.energy) {
      print("  ${energyItem.name}: ${energyItem.average} ${energyItem.measurementUnit}");
    }

    print("\nMain Nutrients:");
    for (var nutrient in nutrientMeasurements.mainNutrients) {
      print("  ${nutrient.name}: ${nutrient.average} ${nutrient.measurementUnit}");
      print("  Components:");
      for (var component in nutrient.components) {
        print("    - ${component.name}: ${component.average} ${component.measurementUnit}");
      }
    }

    print("\nMicronutrients:");
    nutrientMeasurements.micronutrients.forEach((key, list) {
      print("  $key:");
      for (var micronutrient in list) {
        print("    ${micronutrient.name}: ${micronutrient.average} ${micronutrient.measurementUnit}");
      }
    });

    print("\n=== Origins ===");
    if (origins != null && origins!.isNotEmpty) {
      for (var origin in origins!) {
        print("  ${origin.name} (ID: ${origin.id})");
      }
    } else {
      print("  No origins available.");
    }

    print("\n=== Langual Codes ===");
    if (langualCodes.isNotEmpty) {
      for (var langualCode in langualCodes) {
        print("  Descriptor: ${langualCode.descriptor}");
        if (langualCode.children.isNotEmpty) {
          print("    Children:");
          for (var child in langualCode.children) {
            print("      - Code: ${child.code}, Descriptor: ${child.descriptor}");
          }
        }
      }
    } else {
      print("  No Langual codes available.");
    }

    print("\n=== References ===");
    if (references.isNotEmpty) {
      for (var reference in references) {
        print("  Code: ${reference.code}");
        print("  Type: ${reference.type}");
        print("  Title: ${reference.title}");
        print("  Authors: ${reference.authors.join(', ')}");
        print("  Year: ${reference.refYear ?? 'N/A'}");
        print("-------------------");
      }
    } else {
      print("  No references available.");
    }

    print("=============================");
  }

}

class Group {
  final String code;
  final String name;

  Group({required this.code, required this.name});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      code: json['code'] as String,
      name: json['name'] as String,
    );
  }
}

class Type {
  final String code;
  final String name;

  Type({required this.code, required this.name});

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      code: json['code'] as String,
      name: json['name'] as String,
    );
  }
}

class Origin {
  final int id;
  final String name;

  Origin({
    required this.id,
    required this.name,
  });

  factory Origin.fromJson(Map<String, dynamic> json) {
    return Origin(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}

class NutrientMeasurements {
  final List<NutrientMeasurement> energy;
  final List<NutrientMeasurementWithComponents> mainNutrients;
  final Map<String, List<NutrientMeasurement>> micronutrients;

  NutrientMeasurements({
    required this.energy,
    required this.mainNutrients,
    required this.micronutrients,
  });

  factory NutrientMeasurements.fromJson(Map<String, dynamic> json) {
    return NutrientMeasurements(
      energy: (json['energy'] as List)
          .map((e) => NutrientMeasurement.fromJson(e))
          .toList(),
      mainNutrients: (json['mainNutrients'] as List)
          .map((e) => NutrientMeasurementWithComponents.fromJson(e))
          .toList(),
      micronutrients: {
        'vitamins': (json['micronutrients']['vitamins'] as List)
            .map((e) => NutrientMeasurement.fromJson(e))
            .toList(),
        'minerals': (json['micronutrients']['minerals'] as List)
            .map((e) => NutrientMeasurement.fromJson(e))
            .toList(),
      },
    );
  }

  List<NutrientMeasurement> get vitamins => micronutrients['vitamins'] ?? [];

  List<NutrientMeasurement> get minerals => micronutrients['minerals'] ?? [];
}

class NutrientMeasurement {
  final int nutrientId;
  final String name;
  final String measurementUnit;
  final double average;
  final double? deviation;
  final double? min;
  final double? max;
  final int? sampleSize;
  final bool standardized;
  final String dataType;
  final String? note;
  final List<int>? referenceCodes;

  NutrientMeasurement({
    required this.nutrientId,
    required this.name,
    required this.measurementUnit,
    required this.average,
    this.deviation,
    this.min,
    this.max,
    this.sampleSize,
    required this.standardized,
    required this.dataType,
    this.note,
    this.referenceCodes,
  });

  factory NutrientMeasurement.fromJson(Map<String, dynamic> json) {
    return NutrientMeasurement(
      nutrientId: json['nutrientId'] as int,
      name: json['name'] as String,
      measurementUnit: json['measurementUnit'] as String,
      average: (json['average'] as num).toDouble(),
      deviation: (json['deviation'] as num?)?.toDouble(),
      min: (json['min'] as num?)?.toDouble(),
      max: (json['max'] as num?)?.toDouble(),
      sampleSize: json['sampleSize'] as int?,
      standardized: json['standardized'] as bool,
      dataType: json['dataType'] as String,
      note: json['note'] as String?,
      referenceCodes:
      (json['referenceCodes'] as List?)?.map((e) => e as int).toList(),
    );
  }
}

class NutrientMeasurementWithComponents extends NutrientMeasurement {
  final List<NutrientMeasurement> components;

  NutrientMeasurementWithComponents({
    required super.nutrientId,
    required super.name,
    required super.measurementUnit,
    required super.average,
    super.deviation,
    super.min,
    super.max,
    super.sampleSize,
    required super.standardized,
    required super.dataType,
    super.note,
    super.referenceCodes,
    required this.components,
  });

  factory NutrientMeasurementWithComponents.fromJson(
      Map<String, dynamic> json) {
    return NutrientMeasurementWithComponents(
      nutrientId: json['nutrientId'] as int,
      name: json['name'] as String,
      measurementUnit: json['measurementUnit'] as String,
      average: (json['average'] as num).toDouble(),
      deviation: (json['deviation'] as num?)?.toDouble(),
      min: (json['min'] as num?)?.toDouble(),
      max: (json['max'] as num?)?.toDouble(),
      sampleSize: json['sampleSize'] as int?,
      standardized: json['standardized'] as bool,
      dataType: json['dataType'] as String,
      note: json['note'] as String?,
      referenceCodes:
      (json['referenceCodes'] as List?)?.map((e) => e as int).toList(),
      components: (json['components'] as List)
          .map((e) => NutrientMeasurement.fromJson(e))
          .toList(),
    );
  }
}

class LangualCode {
  final String descriptor;
  final List<LangualCodeChild> children;

  LangualCode({
    required this.descriptor,
    required this.children,
  });

  factory LangualCode.fromJson(Map<String, dynamic> json) {
    return LangualCode(
      descriptor: json['descriptor'] as String,
      children: (json['children'] as List)
          .map((e) => LangualCodeChild.fromJson(e))
          .toList(),
    );
  }
}

class LangualCodeChild {
  final String code;
  final String descriptor;

  LangualCodeChild({required this.code, required this.descriptor});

  factory LangualCodeChild.fromJson(Map<String, dynamic> json) {
    return LangualCodeChild(
      code: json['code'] as String,
      descriptor: json['descriptor'] as String,
    );
  }
}

class Reference {
  final int code;
  final String type;
  final String title;
  final List<String> authors;
  final int? refYear;

  Reference({
    required this.code,
    required this.type,
    required this.title,
    required this.authors,
    this.refYear,
  });

  factory Reference.fromJson(Map<String, dynamic> json) {
    return Reference(
      code: json['code'] as int,
      type: json['type'] as String,
      title: json['title'] as String,
      authors: List<String>.from(json['authors']),
      refYear: json['refYear'] as int?,
    );
  }
}
