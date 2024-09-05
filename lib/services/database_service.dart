import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pp_463/data/entity/nutrition_entity.dart';
import 'package:pp_463/data/entity/ration_entity.dart';
import 'package:pp_463/data/entity/recipe_entity.dart';
import 'package:pp_463/data/models/nutrition.dart';
import 'package:pp_463/data/models/ration.dart';
import 'package:pp_463/data/models/recipe.dart';

class DatabaseService {
  late final Box<dynamic> _common;
  late final Box<RationEntity> _rations;
  late final Box<RecipeEntity> _recipes;
  late final Box<NutritionEntity> _nutritions;

  Future<DatabaseService> init() async {
    await Hive.initFlutter();
    final appDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDirectory.path);

    Hive.registerAdapter(RationEntityAdapter());
    Hive.registerAdapter(RecipeEntityAdapter());
    Hive.registerAdapter(RecipeAdapter());
    Hive.registerAdapter(NutritionEntityAdapter());

    _common = await Hive.openBox('_common');
    _rations = await Hive.openBox('_rations');
    _recipes = await Hive.openBox('_recipes');
    _nutritions = await Hive.openBox('_nutritions');

    return this;
  }

  // Ration

  Future<void> setInitialRation() async {
    Ration initialRation = Ration(
      breakfast: [],
      lunch: [],
      dinner: [],
      snack: [],
      water: 0,
      date: DateTime.now(),
    );

    await _rations.add(RationEntity.fromOriginal(initialRation));
  }

  List<Ration> get rations =>
      _rations.values.map((e) => Ration.fromEntity(e)).toList();

  Future<void> addRation(Ration ration) async =>
      await _rations.add(RationEntity.fromOriginal(ration));

  Future<void> deleteRation(int index) async => await _rations.deleteAt(index);

  Future<void> editRation(int index, Ration editRation) async =>
      await _rations.putAt(index, RationEntity.fromOriginal(editRation));

  bool get isRationsEmpty => _rations.values.isEmpty;

  bool get isRationsNotEmpty => _rations.values.isNotEmpty;

  // Recipe

  List<Recipe> get recipes =>
      _recipes.values.map((e) => Recipe.fromEntity(e)).toList();

  Future<void> addRecipe(Recipe recipe) async =>
      await _recipes.add(RecipeEntity.fromOriginal(recipe));

  Future<void> deleteRecipe(int index) async => await _recipes.deleteAt(index);

  Future<void> editRecipe(int index, Recipe editRecipe) async =>
      await _recipes.putAt(index, RecipeEntity.fromOriginal(editRecipe));

  bool get isRecipesEmpty => _recipes.values.isEmpty;

  bool get isRecipesNotEmpty => _recipes.values.isNotEmpty;

  // Nutrition

  Future<void> setInitialNutrition() async {
    Nutrition initialNutrition = Nutrition(
      carbs: 200,
      protein: 100,
      fats: 50,
      calories: 1100,
    );
    await _nutritions.put(
        'default_nutrition', NutritionEntity.fromOriginal(initialNutrition));
  }

  Future<void> updateNutrition(Nutrition nutrition) async {
    await _nutritions.put(
        'default_nutrition', NutritionEntity.fromOriginal(nutrition));
  }

  Nutrition? get nutrition =>
      Nutrition.fromEntity(_nutritions.get('default_nutrition')!);

  // COMMON

  void put(String key, dynamic value) => _common.put(key, value);

  dynamic get(String key) => _common.get(key);
}
