import 'package:hive_flutter/hive_flutter.dart';
import 'package:pp_463/data/models/nutrition.dart';

part 'nutrition_entity.g.dart';

@HiveType(typeId: 3)
class NutritionEntity extends HiveObject {
  @HiveField(0)
  int carbs;
  @HiveField(1)
  int protein;
  @HiveField(2)
  int fats;
  @HiveField(3)
  int calories;

  NutritionEntity({
    required this.carbs,
    required this.protein,
    required this.fats,
    required this.calories,
  });

  factory NutritionEntity.fromOriginal(Nutrition original) => NutritionEntity(
        carbs: original.carbs,
        protein: original.protein,
        fats: original.fats,
        calories: original.calories,
      );
}
