import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pp_463/data/entity/recipe_entity.dart';

part 'recipe.g.dart';

@HiveType(typeId: 1)
class Recipe extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final DateTime time;
  @HiveField(2)
  final List<String> ingredients;
  @HiveField(3)
  final int carbs;
  @HiveField(4)
  final int protein;
  @HiveField(5)
  final int fats;
  @HiveField(6)
  final int calories;

  const Recipe({
    required this.name,
    required this.time,
    required this.ingredients,
    required this.carbs,
    required this.protein,
    required this.fats,
    required this.calories,
  });

  factory Recipe.fromEntity(RecipeEntity entity) => Recipe(
    name: entity.name,
    time: entity.time,
    ingredients: entity.ingredients,
    carbs: entity.carbs,
    protein: entity.protein,
    fats: entity.fats,
    calories: entity.calories,
  );

  @override
  List<Object?> get props => [
    name,
    time,
    ingredients,
    carbs,
    protein,
    fats,
    calories,
  ];
}
