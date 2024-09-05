import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:pp_463/data/models/nutrition.dart';
import 'package:pp_463/data/models/ration.dart';
import 'package:pp_463/data/models/recipe.dart';
import 'package:pp_463/services/database_service.dart';

part 'statistic_event.dart';

part 'statistic_state.dart';

class StatisticBloc extends Bloc<StatisticEvent, StatisticState> {
  StatisticBloc() : super(StatisticInitial()) {
    on<GetNutritionEvent>(_getNutritionHandler);
    on<UpdateNutritionEvent>(_updateNutritionHandler);

    on<GetWeeklyProgressEvent>(_getWeeklyProgressHandler);
    on<GetDailyStatisticEvent>(_getDailyStatisticHandler);
  }

  final _databaseService = GetIt.instance<DatabaseService>();

  void _getNutritionHandler(
      GetNutritionEvent event, Emitter<StatisticState> emit) async {
    final nutrition = _databaseService.nutrition;

    emit(LoadNutritionState(nutrition: nutrition!));
  }

  void _updateNutritionHandler(
      UpdateNutritionEvent event, Emitter<StatisticState> emit) async {
    _databaseService.updateNutrition(event.nutrition);
  }

  void _getWeeklyProgressHandler(
      GetWeeklyProgressEvent event, Emitter<StatisticState> emit) async {
    if (_databaseService.isRationsNotEmpty) {
      DateTime now = DateTime.now();
      int totalCalories = 0;
      for (var ration in _databaseService.rations) {
        if (now.difference(ration.date).inDays < 7) {
          totalCalories += ration.breakfast
              .fold(0, (prev, recipe) => prev + recipe.calories);
          totalCalories +=
              ration.lunch.fold(0, (prev, recipe) => prev + recipe.calories);
          totalCalories +=
              ration.dinner.fold(0, (prev, recipe) => prev + recipe.calories);
          totalCalories +=
              ration.snack.fold(0, (prev, recipe) => prev + recipe.calories);
        }
      }
      int averageCalories = _databaseService.nutrition!.calories * 7;

      double rate = totalCalories / averageCalories;

      emit(LoadWeeklyProgressState(rate: rate, kcal: totalCalories));
    }
  }

  void _getDailyStatisticHandler(
      GetDailyStatisticEvent event, Emitter<StatisticState> emit) async {

    int carbs = 0;
    int protein = 0;
    int fats = 0;

    void calculateMacros(List<Recipe> meals) {
      if (meals.isNotEmpty) {
        carbs += meals.fold(0, (total, recipe) => total + recipe.carbs);
        protein += meals.fold(0, (total, recipe) => total + recipe.protein);
        fats += meals.fold(0, (total, recipe) => total + recipe.fats);
      }
    }

    calculateMacros(event.ration.breakfast);
    calculateMacros(event.ration.lunch);
    calculateMacros(event.ration.dinner);
    calculateMacros(event.ration.snack);

    Nutrition nutrition = _databaseService.nutrition!;

    double carbsRate = carbs / nutrition.carbs;
    double proteinRate = protein / nutrition.protein;
    double fatsRate = fats / nutrition.fats;

    emit(
      LoadDailyStatisticState(
        carbsRate: carbsRate,
        carbs: carbs,
        proteinRate: proteinRate,
        protein: protein,
        fatsRate: fatsRate,
        fats: fats,
      ),
    );
  }

}
