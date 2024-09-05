part of 'statistic_bloc.dart';

@immutable
sealed class StatisticState {}

final class StatisticInitial extends StatisticState {}

final class LoadNutritionState extends StatisticState {
  final Nutrition nutrition;

  LoadNutritionState({required this.nutrition});
}

final class LoadWeeklyProgressState extends StatisticState {
  final double rate;
  final int kcal;

  LoadWeeklyProgressState({required this.rate, required this.kcal});
}

final class LoadDailyStatisticState extends StatisticState {
  final double carbsRate;
  final int carbs;

  final double proteinRate;
  final int protein;

  final double fatsRate;
  final int fats;

  LoadDailyStatisticState(
      {required this.carbsRate,
      required this.carbs,
      required this.proteinRate,
      required this.protein,
      required this.fatsRate,
      required this.fats});
}
