part of 'ration_bloc.dart';

@immutable
sealed class RationEvent {}

class GetRationEvent extends RationEvent {
  final DateTime date;

  GetRationEvent({required this.date});
}

class UpdateRationTypeEvent extends RationEvent {
  final Ration ration;
  final List<Recipe> recipes;
  final RationType type;

  UpdateRationTypeEvent({required this.ration, required this.recipes, required this.type});
}

class IncrementWaterEvent extends RationEvent {
  final Ration ration;

  IncrementWaterEvent({required this.ration});
}

class DecrementWaterEvent extends RationEvent {
  final Ration ration;

  DecrementWaterEvent({required this.ration});
}