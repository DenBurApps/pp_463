import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pp_463/data/models/ration.dart';
import 'package:pp_463/data/models/ration_type.dart';
import 'package:pp_463/data/models/recipe.dart';
import 'package:pp_463/router/router.dart';
import 'package:pp_463/screens/ration/ration_bloc/ration_bloc.dart';
import 'package:pp_463/screens/recipe/recipe_bloc/recipe_bloc.dart';
import 'package:pp_463/theme/textstyles.dart';
import 'package:pp_463/theme/theme.dart';
import 'package:pp_463/widgets/app_action_button.dart';

@RoutePage()
class RecipeListScreen extends StatefulWidget {
  final Ration ration;
  final RationType type;
  final List<Recipe> recipes;

  const RecipeListScreen(
      {super.key,
      required this.ration,
      required this.type,
      required this.recipes});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  late final searchController;

  List<Recipe> recipes = [];

  void _init() {
    searchController = TextEditingController();
    context.read<RecipeBloc>().add(GetRecipesEvent());
    recipes = widget.recipes;
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: _colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/elements/appbar-bg.png"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              height: MediaQuery.of(context).size.height * .25,
              width: MediaQuery.of(context).size.width,
              child: SafeArea(
                bottom: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => context.router.navigate(MainRoute()),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: _colorScheme.onPrimary,
                          ),
                        ),
                        Spacer(flex: 4),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.type.label,
                              style: AppTextStyles.displaySmall(
                                  _colorScheme.onPrimary),
                            ),
                            Text(
                              'Choose recipe',
                              style: AppTextStyles.bodyMedium(
                                  _colorScheme.onPrimary),
                            ),
                          ],
                        ),
                        Spacer(flex: 2),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  context.router.push(RecipesInfoRoute()),
                              child: Icon(
                                Icons.list_alt_rounded,
                                size: 30,
                                color: _colorScheme.surfaceContainer,
                              ),
                            ),
                            SizedBox(width: 15),
                            GestureDetector(
                              onTap: () =>
                                  context.router.push(AddRecipeRoute()),
                              child: Icon(
                                Icons.add_circle,
                                size: 30,
                                color: _colorScheme.surfaceContainer,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      style: AppTextStyles.bodyMedium(_colorScheme.secondary),
                      controller: searchController,
                      maxLines: 1,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.red,
                        ),
                        hintText: 'Search',
                        hintStyle: AppTextStyles.bodyMedium(
                            _colorScheme.secondary.withOpacity(.3)),
                        filled: true,
                        fillColor: _colorScheme.onPrimary,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14.0)),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14.0)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (query) => _onSearch(query),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            BlocBuilder<RecipeBloc, RecipeState>(
              builder: (context, state) {
                if (state is LoadedRecipesState) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10.0,
                      runSpacing: 15,
                      children:
                          List<Widget>.generate(state.recipes.length, (index) {
                        final tile = state.recipes[index];
                        return ChoiceChip(
                            padding: EdgeInsets.all(10),
                            backgroundColor: _colorScheme.surface,
                            selectedColor: _colorScheme.surface,
                            showCheckmark: false,
                            side: BorderSide.none,
                            label: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tile.name,
                                        style: AppTextStyles.bodyMedium(
                                            _colorScheme.secondary),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        '${tile.calories} kcal',
                                        style: AppTextStyles.bodySmall(
                                            _colorScheme.secondary
                                                .withOpacity(.6)),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        '${tile.time.hour} h ${tile.time.minute} min',
                                        style: AppTextStyles.bodySmall(
                                            _colorScheme.secondary
                                                .withOpacity(.6)),
                                      ),
                                    ],
                                  ),
                                ),
                                recipes.contains(state.recipes[index])
                                    ? Icon(
                                        Icons.check_circle,
                                        color: AppColors.green,
                                        size: 40,
                                      )
                                    : Icon(
                                        Icons.add_circle,
                                        color: _colorScheme.surfaceContainer,
                                        size: 40,
                                      ),
                              ],
                            ),
                            selected: recipes.contains(state.recipes[index]),
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  recipes.add(state.recipes[index]);
                                } else {
                                  recipes.remove(state.recipes[index]);
                                }
                              });
                            });
                      }),
                    ),
                  );
                } else if (state is EmptyRecipesState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      SvgPicture.asset('assets/images/elements/empty.svg'),
                      SizedBox(height: 20),
                      Text(
                        'You don\'t have any recipes yet.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMedium(
                            _colorScheme.secondary.withOpacity(.4)),
                      ),
                    ],
                  );
                } else if (state is FailureSearchResultState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      SvgPicture.asset('assets/images/elements/empty.svg'),
                      SizedBox(height: 20),
                      Text(
                        'Unfortunately, nothing was found',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMedium(
                            _colorScheme.secondary.withOpacity(.4)),
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
            SizedBox(height: 150),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16),
        child: AppActionButton(
          text: 'Done',
          width: double.infinity,
          onPressed: () => _onDone(),
        ),
      ),
    );
  }

  void _onDone() {
    if (recipes.isNotEmpty) {
      context.read<RationBloc>().add(UpdateRationTypeEvent(
          ration: widget.ration, recipes: recipes, type: widget.type));
      context.router.push(MainRoute());
    } else {
      _showFailedSnackBar('Incorrect information');
    }
  }

  void _onSearch(String query) {
    setState(() {
      if (query.isNotEmpty) {
        context.read<RecipeBloc>().add(SearchRecipesEvent(query: query));
      } else {
        context.read<RecipeBloc>().add(GetRecipesEvent());
      }
    });
  }

  void _showFailedSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.error,
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
