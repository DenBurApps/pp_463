import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:pp_463/data/models/nutrition.dart';
import 'package:pp_463/data/models/ration.dart';
import 'package:pp_463/data/models/ration_type.dart';
import 'package:pp_463/data/models/recipe.dart';
import 'package:pp_463/services/database_service.dart';

part 'ration_event.dart';

part 'ration_state.dart';

class RationBloc extends Bloc<RationEvent, RationState> {
  RationBloc() : super(RationInitial()) {
    on<GetRationEvent>(_getRationHandler);
    on<UpdateRationTypeEvent>(_updateRationTypeHandler);

    on<IncrementWaterEvent>(_incrementWaterHandler);
    on<DecrementWaterEvent>(_decrementWaterHandler);
  }

  final _databaseService = GetIt.instance<DatabaseService>();

  void _getRationHandler(
      GetRationEvent event, Emitter<RationState> emit) async {
    Ration? currentRation;
    for (Ration ration in _databaseService.rations) {
      if (event.date.year == ration.date.year &&
          event.date.month == ration.date.month &&
          event.date.day == ration.date.day) {
        currentRation = ration;
        break;
      }
    }
    if (currentRation != null) {
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

      calculateMacros(currentRation.breakfast);
      calculateMacros(currentRation.lunch);
      calculateMacros(currentRation.dinner);
      calculateMacros(currentRation.snack);

      Nutrition nutrition = _databaseService.nutrition!;

      double carbsRate = carbs / nutrition.carbs;
      double proteinRate = protein / nutrition.protein;
      double fatsRate = fats / nutrition.fats;

      emit(LoadRationState(
        ration: currentRation,
        carbsRate: carbsRate,
        carbs: carbs,
        proteinRate: proteinRate,
        protein: protein,
        fatsRate: fatsRate,
        fats: fats,
      ));
    } else {
      Ration newRation = Ration(
        breakfast: [],
        lunch: [],
        dinner: [],
        snack: [],
        water: 0,
        date: event.date,
      );
      currentRation = newRation;
      _databaseService.addRation(currentRation);
      emit(LoadRationState(
        ration: currentRation,
        carbs: 0,
        proteinRate: 0,
        protein: 0,
        fatsRate: 0,
        fats: 0,
        carbsRate: 0,
      ));
    }
  }

  void _updateRationTypeHandler(
      UpdateRationTypeEvent event, Emitter<RationState> emit) async {
    final int foundIndex = _databaseService.rations.indexOf(event.ration);

    Ration editRation = event.ration;

    switch (event.type) {
      case RationType.breakfast:
        editRation.breakfast = event.recipes;
      case RationType.lunch:
        editRation.lunch = event.recipes;
      case RationType.dinner:
        editRation.dinner = event.recipes;
      case RationType.snack:
        editRation.snack = event.recipes;
    }

    _databaseService.editRation(foundIndex, editRation);
  }

  void _incrementWaterHandler(
      IncrementWaterEvent event, Emitter<RationState> emit) async {
    final int foundIndex = _databaseService.rations.indexOf(event.ration);

    Ration editRation = event.ration;
    editRation.water += 0.25;

    _databaseService.editRation(foundIndex, editRation);
  }

  void _decrementWaterHandler(
      DecrementWaterEvent event, Emitter<RationState> emit) async {
    final int foundIndex = _databaseService.rations.indexOf(event.ration);

    Ration editRation = event.ration;

    if (editRation.water > 0) {
      editRation.water -= 0.25;
    }

    _databaseService.editRation(foundIndex, editRation);
  }
}
