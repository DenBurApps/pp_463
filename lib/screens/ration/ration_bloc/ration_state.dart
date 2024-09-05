part of 'ration_bloc.dart';

@immutable
sealed class RationState {}

final class RationInitial extends RationState {}

final class LoadRationState extends RationState {
  final Ration ration;

  final double carbsRate;
  final int carbs;

  final double proteinRate;
  final int protein;

  final double fatsRate;
  final int fats;

  LoadRationState({required this.ration, required this.carbsRate, required this.carbs, required this.proteinRate, required this.protein, required this.fatsRate, required this.fats});


}
