import 'package:hive_flutter/hive_flutter.dart';
import 'package:pp_463/data/models/ration.dart';
import 'package:pp_463/data/models/recipe.dart';

part 'ration_entity.g.dart';

@HiveType(typeId: 0)
class RationEntity extends HiveObject {
  @HiveField(0)
  List<Recipe> breakfast;
  @HiveField(1)
  List<Recipe> lunch;
  @HiveField(2)
  List<Recipe> dinner;
  @HiveField(3)
  List<Recipe> snack;
  @HiveField(4)
  double water;
  @HiveField(5)
  DateTime date;

  RationEntity({
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.snack,
    required this.water,
    required this.date,
  });

  factory RationEntity.fromOriginal(Ration original) => RationEntity(
        breakfast: original.breakfast,
        lunch: original.lunch,
        dinner: original.dinner,
        snack: original.snack,
        water: original.water,
        date: original.date,
      );
}
