part of 'statistic_bloc.dart';

@immutable
sealed class StatisticEvent {}

class GetNutritionEvent extends StatisticEvent {}

class UpdateNutritionEvent extends StatisticEvent {
  final Nutrition nutrition;

  UpdateNutritionEvent({required this.nutrition});
}

class GetWeeklyProgressEvent extends StatisticEvent {}

class GetDailyStatisticEvent extends StatisticEvent {
  final Ration ration;

  GetDailyStatisticEvent({required this.ration});
}