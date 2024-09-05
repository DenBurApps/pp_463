// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [AddRecipeScreen]
class AddRecipeRoute extends PageRouteInfo<void> {
  const AddRecipeRoute({List<PageRouteInfo>? children})
      : super(
          AddRecipeRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddRecipeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AddRecipeScreen();
    },
  );
}

/// generated route for
/// [AgreementScreen]
class AgreementRoute extends PageRouteInfo<AgreementRouteArgs> {
  AgreementRoute({
    Key? key,
    required AgreementViewArguments arguments,
    List<PageRouteInfo>? children,
  }) : super(
          AgreementRoute.name,
          args: AgreementRouteArgs(
            key: key,
            arguments: arguments,
          ),
          initialChildren: children,
        );

  static const String name = 'AgreementRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AgreementRouteArgs>();
      return AgreementScreen(
        key: args.key,
        arguments: args.arguments,
      );
    },
  );
}

class AgreementRouteArgs {
  const AgreementRouteArgs({
    this.key,
    required this.arguments,
  });

  final Key? key;

  final AgreementViewArguments arguments;

  @override
  String toString() {
    return 'AgreementRouteArgs{key: $key, arguments: $arguments}';
  }
}

/// generated route for
/// [EditRecipeScreen]
class EditRecipeRoute extends PageRouteInfo<EditRecipeRouteArgs> {
  EditRecipeRoute({
    Key? key,
    required Recipe recipe,
    List<PageRouteInfo>? children,
  }) : super(
          EditRecipeRoute.name,
          args: EditRecipeRouteArgs(
            key: key,
            recipe: recipe,
          ),
          initialChildren: children,
        );

  static const String name = 'EditRecipeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditRecipeRouteArgs>();
      return EditRecipeScreen(
        key: args.key,
        recipe: args.recipe,
      );
    },
  );
}

class EditRecipeRouteArgs {
  const EditRecipeRouteArgs({
    this.key,
    required this.recipe,
  });

  final Key? key;

  final Recipe recipe;

  @override
  String toString() {
    return 'EditRecipeRouteArgs{key: $key, recipe: $recipe}';
  }
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainScreen();
    },
  );
}

/// generated route for
/// [OnboardingScreen]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OnboardingScreen();
    },
  );
}

/// generated route for
/// [RecipeListScreen]
class RecipeListRoute extends PageRouteInfo<RecipeListRouteArgs> {
  RecipeListRoute({
    Key? key,
    required Ration ration,
    required RationType type,
    required List<Recipe> recipes,
    List<PageRouteInfo>? children,
  }) : super(
          RecipeListRoute.name,
          args: RecipeListRouteArgs(
            key: key,
            ration: ration,
            type: type,
            recipes: recipes,
          ),
          initialChildren: children,
        );

  static const String name = 'RecipeListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RecipeListRouteArgs>();
      return RecipeListScreen(
        key: args.key,
        ration: args.ration,
        type: args.type,
        recipes: args.recipes,
      );
    },
  );
}

class RecipeListRouteArgs {
  const RecipeListRouteArgs({
    this.key,
    required this.ration,
    required this.type,
    required this.recipes,
  });

  final Key? key;

  final Ration ration;

  final RationType type;

  final List<Recipe> recipes;

  @override
  String toString() {
    return 'RecipeListRouteArgs{key: $key, ration: $ration, type: $type, recipes: $recipes}';
  }
}

/// generated route for
/// [RecipesInfoScreen]
class RecipesInfoRoute extends PageRouteInfo<void> {
  const RecipesInfoRoute({List<PageRouteInfo>? children})
      : super(
          RecipesInfoRoute.name,
          initialChildren: children,
        );

  static const String name = 'RecipesInfoRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RecipesInfoScreen();
    },
  );
}

/// generated route for
/// [SettingsListScreen]
class SettingsListRoute extends PageRouteInfo<void> {
  const SettingsListRoute({List<PageRouteInfo>? children})
      : super(
          SettingsListRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsListScreen();
    },
  );
}

/// generated route for
/// [StatisticDetailsScreen]
class StatisticDetailsRoute extends PageRouteInfo<void> {
  const StatisticDetailsRoute({List<PageRouteInfo>? children})
      : super(
          StatisticDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'StatisticDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const StatisticDetailsScreen();
    },
  );
}

/// generated route for
/// [UpdateNutritionScreen]
class UpdateNutritionRoute extends PageRouteInfo<UpdateNutritionRouteArgs> {
  UpdateNutritionRoute({
    Key? key,
    required Nutrition nutrition,
    List<PageRouteInfo>? children,
  }) : super(
          UpdateNutritionRoute.name,
          args: UpdateNutritionRouteArgs(
            key: key,
            nutrition: nutrition,
          ),
          initialChildren: children,
        );

  static const String name = 'UpdateNutritionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UpdateNutritionRouteArgs>();
      return UpdateNutritionScreen(
        key: args.key,
        nutrition: args.nutrition,
      );
    },
  );
}

class UpdateNutritionRouteArgs {
  const UpdateNutritionRouteArgs({
    this.key,
    required this.nutrition,
  });

  final Key? key;

  final Nutrition nutrition;

  @override
  String toString() {
    return 'UpdateNutritionRouteArgs{key: $key, nutrition: $nutrition}';
  }
}
