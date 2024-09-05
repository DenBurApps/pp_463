import 'package:equatable/equatable.dart';
import 'package:pp_463/data/entity/ration_entity.dart';
import 'package:pp_463/data/models/recipe.dart';

class Ration extends Equatable {
  List<Recipe> breakfast;
  List<Recipe> lunch;
  List<Recipe> dinner;
  List<Recipe> snack;
  double water;
  DateTime date;


  Ration({
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.snack,
    required this.water,
    required this.date,
  });

  factory Ration.fromEntity(RationEntity entity) => Ration(
    breakfast: entity.breakfast,
    lunch: entity.lunch,
    dinner: entity.dinner,
    snack: entity.snack,
    water: entity.water,
    date: entity.date,

  );

  @override
  List<Object?> get props => [
    breakfast,
    lunch,
    dinner,
    snack,
    water,
    date,

  ];
}
