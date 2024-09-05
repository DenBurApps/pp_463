import 'package:auto_route/auto_route.dart';

import 'package:pp_463/data/models/ration.dart';
import 'package:pp_463/data/models/ration_type.dart';
import 'package:pp_463/data/models/recipe.dart';
import 'package:pp_463/data/models/nutrition.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pp_463/data/database_keys.dart';
import 'package:pp_463/screens/main/main_screen.dart';
import 'package:pp_463/screens/onboarding/onboarding_screen.dart';
import 'package:pp_463/screens/recipe/add_recipe/add_recipe_screen.dart';
import 'package:pp_463/screens/recipe/edit_recipe/edit_recipe_screen.dart';
import 'package:pp_463/screens/recipe/recipe_list/recipe_list_screen.dart';
import 'package:pp_463/screens/recipe/recipes_info/recipes_info_screen.dart';
import 'package:pp_463/screens/settings/agreement_screen.dart';
import 'package:pp_463/screens/settings/settings_list_screen.dart';
import 'package:pp_463/screens/statistic/statistic_details/statistic_details_screen.dart';
import 'package:pp_463/screens/statistic/update_nutrition/update_nutrition_screen.dart';
import 'package:pp_463/services/database_service.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes {
    final _databaseService = GetIt.instance<DatabaseService>();
    final seenOnboarding =
        _databaseService.get(DatabaseKeys.seenOnboarding) ?? false;
    return [
      AutoRoute(
        page: OnboardingRoute.page,
        initial: seenOnboarding,
      ),
      AutoRoute(
        page: MainRoute.page,
        initial: !seenOnboarding,
      ),
      AutoRoute(page: RecipeListRoute.page),
      AutoRoute(page: AddRecipeRoute.page),
      AutoRoute(page: EditRecipeRoute.page),
      AutoRoute(page: RecipesInfoRoute.page),

      AutoRoute(page: StatisticDetailsRoute.page),
      AutoRoute(page: UpdateNutritionRoute.page),

      AutoRoute(page: SettingsListRoute.page),
      AutoRoute(page: AgreementRoute.page),
    ];
  }
}
