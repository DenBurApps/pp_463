import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:pp_463/data/models/recipe.dart';
import 'package:pp_463/services/database_service.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc() : super(RecipeInitial()) {
    on<GetRecipesEvent>(_getRecipesHandler);
    on<SearchRecipesEvent>(_searchRecipesHandler);

    on<AddRecipeEvent>(_addRecipeHandler);
    on<EditRecipeEvent>(_editRecipeHandler);
    on<DeleteRecipeEvent>(_deleteRecipeHandler);
  }

  final _databaseService = GetIt.instance<DatabaseService>();

  void _getRecipesHandler(
      GetRecipesEvent event, Emitter<RecipeState> emit) async {
    if (_databaseService.isRecipesNotEmpty) {
      emit(LoadedRecipesState(recipes: _databaseService.recipes));
    } else {
      emit(EmptyRecipesState());
    }
  }

  void _addRecipeHandler(
      AddRecipeEvent event, Emitter<RecipeState> emit) async {
    _databaseService.addRecipe(event.recipe);
  }

  void _editRecipeHandler(
      EditRecipeEvent event, Emitter<RecipeState> emit) async {
    final int foundIndex =
    _databaseService.recipes.indexOf(event.recipe);
    _databaseService.editRecipe(foundIndex, event.editRecipe);
  }

  void _deleteRecipeHandler(
      DeleteRecipeEvent event, Emitter<RecipeState> emit) async {
    final int foundIndex =
    _databaseService.recipes.indexOf(event.recipe);
    _databaseService.deleteRecipe(foundIndex);
  }

  void _searchRecipesHandler(
      SearchRecipesEvent event, Emitter<RecipeState> emit) async {
    if (_databaseService.isRecipesNotEmpty) {
      final suggestions = _databaseService.recipes.where((item) {
        final itemName = item.name.toLowerCase();
        final input = event.query.toLowerCase();

        return itemName.contains(input);
      }).toList();

      if (suggestions.isNotEmpty) {
        emit(LoadedRecipesState(recipes: suggestions));
      } else {
        emit(FailureSearchResultState());
      }
    } else {
      emit(EmptyRecipesState());
    }
  }
}