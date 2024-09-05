part of 'recipe_bloc.dart';

@immutable
sealed class RecipeState {}

final class RecipeInitial extends RecipeState {}

class LoadedRecipesState extends RecipeState {
  final List<Recipe> recipes;

  LoadedRecipesState({required this.recipes});
}

class EmptyRecipesState extends RecipeState {}

class FailureSearchResultState extends RecipeState {}
