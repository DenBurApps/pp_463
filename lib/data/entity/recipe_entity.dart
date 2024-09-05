import 'package:hive_flutter/hive_flutter.dart';
import 'package:pp_463/data/models/recipe.dart';

part 'recipe_entity.g.dart';

@HiveType(typeId: 2)
class RecipeEntity extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  DateTime time;
  @HiveField(2)
  List<String> ingredients;
  @HiveField(3)
  int carbs;
  @HiveField(4)
  int protein;
  @HiveField(5)
  int fats;
  @HiveField(6)
  int calories;

  RecipeEntity({
    required this.name,
    required this.time,
    required this.ingredients,
    required this.carbs,
    required this.protein,
    required this.fats,
    required this.calories,
  });

  factory RecipeEntity.fromOriginal(Recipe original) => RecipeEntity(
    name: original.name,
    time: original.time,
    ingredients: original.ingredients,
    carbs: original.carbs,
    protein: original.protein,
    fats: original.fats,
    calories: original.calories,
  );
}