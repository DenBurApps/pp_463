part of 'recipe_bloc.dart';

@immutable
sealed class RecipeEvent {}

class GetRecipesEvent extends RecipeEvent {}

class SearchRecipesEvent extends RecipeEvent {
  final String query;

  SearchRecipesEvent({required this.query});
}

class AddRecipeEvent extends RecipeEvent {
  final Recipe recipe;

  AddRecipeEvent({required this.recipe});
}

class EditRecipeEvent extends RecipeEvent {
  final Recipe editRecipe;
  final Recipe recipe;

  EditRecipeEvent({required this.editRecipe, required this.recipe});
}

class DeleteRecipeEvent extends RecipeEvent {
  final Recipe recipe;

  DeleteRecipeEvent({required this.recipe});
}