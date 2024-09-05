import 'package:equatable/equatable.dart';
import 'package:pp_463/data/entity/nutrition_entity.dart';

class Nutrition extends Equatable {
  final int carbs;
  final int protein;
  final int fats;
  final int calories;

  Nutrition({
    required this.carbs,
    required this.protein,
    required this.fats,
    required this.calories,
  });

  factory Nutrition.fromEntity(NutritionEntity entity) => Nutrition(
    carbs: entity.carbs,
    protein: entity.protein,
    fats: entity.fats,
    calories: entity.calories,
  );

  @override
  List<Object?> get props => [
    carbs,
    protein,
    fats,
    calories,
  ];
}
