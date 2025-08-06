class FoodDetails {
  final Ingredients? ingredients;
  final FoodGroup? group;
  final FoodType? type;
  final String? strain;
  final String? brand;
  final String? observation;
  final List<Origin>? origins;
  final List<LangualCode>? langualCodes;
  final NutrientMeasurements? nutrientMeasurements;
  final List<Reference>? references;
  final CommonName? commonName;
  final String? scientificName;
  final String? subspecies;

  FoodDetails({
    this.ingredients,
    this.group,
    this.type,
    this.strain,
    this.brand,
    this.observation,
    this.origins,
    this.langualCodes,
    this.nutrientMeasurements,
    this.references,
    this.commonName,
    this.scientificName,
    this.subspecies,
  });
}

class CommonName {
  final String? es;
  final String? en;
  final String? pt;

  CommonName({this.es, this.en, this.pt});
}

class Ingredients {
  final String? es;
  final String? en;
  final String? pt;

  Ingredients({this.es, this.en, this.pt});
}

class FoodGroup {
  final String? code;
  final String? name;

  FoodGroup({this.code, this.name});
}

class FoodType {
  final String? code;
  final String? name;

  FoodType({this.code, this.name});
}

class Origin {
  final int? id;
  final String? name;

  Origin({this.id, this.name});
}

class LangualCode {
  final int? id;
  final String? code;
  final String? descriptor;
  final List<LangualChild>? children;

  LangualCode({this.id, this.code, this.descriptor, this.children});
}

class LangualChild {
  final int? id;
  final String? code;
  final String? descriptor;

  LangualChild({this.id, this.code, this.descriptor});
}

class NutrientMeasurements {
  final List<Nutrient>? energy;
  final List<Nutrient>? macronutrients;
  final Micronutrients? micronutrients;

  NutrientMeasurements({
    this.energy,
    this.macronutrients,
    this.micronutrients,
  });
}

class Nutrient {
  final int? nutrientId;
  final String? name;
  final String? measurementUnit;
  final num? average;
  final num? deviation;
  final num? min;
  final num? max;
  final int? sampleSize;
  final bool? standardized;
  final String? dataType;
  final String? note;
  final List<int>? referenceCodes;
  final List<Nutrient>? components;

  Nutrient({
    this.nutrientId,
    this.name,
    this.measurementUnit,
    this.average,
    this.deviation,
    this.min,
    this.max,
    this.sampleSize,
    this.standardized,
    this.dataType,
    this.note,
    this.referenceCodes,
    this.components,
  });
}

class Micronutrients {
  final List<Nutrient>? vitamins;
  final List<Nutrient>? minerals;

  Micronutrients({this.vitamins, this.minerals});
}

class Reference {
  final int? code;
  final String? title;
  final String? type;
  final List<String>? authors;
  final int? year;
  final String? other;
  final int? volume;
  final int? issue;
  final int? volumeYear;
  final String? journalName;
  final int? pageStart;
  final int? pageEnd;
  final String? city;

  Reference({
    this.code,
    this.title,
    this.type,
    this.authors,
    this.year,
    this.other,
    this.volume,
    this.issue,
    this.volumeYear,
    this.journalName,
    this.pageStart,
    this.pageEnd,
    this.city,
  });
}