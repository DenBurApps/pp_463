import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pp_463/router/router.dart';
import 'package:pp_463/screens/recipe/recipe_bloc/recipe_bloc.dart';
import 'package:pp_463/theme/textstyles.dart';
import 'package:pp_463/theme/theme.dart';

@RoutePage()
class RecipesInfoScreen extends StatefulWidget {
  const RecipesInfoScreen({super.key});

  @override
  State<RecipesInfoScreen> createState() => _RecipesInfoScreenState();
}

class _RecipesInfoScreenState extends State<RecipesInfoScreen> {
  late final searchController;

  void _init() {
    searchController = TextEditingController();
    context.read<RecipeBloc>().add(GetRecipesEvent());
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

    return PopScope(
      canPop: false,
      child: Scaffold(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => context.router.push(MainRoute()),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: _colorScheme.onPrimary,
                            ),
                          ),
                          Text(
                            'All Recipes',
                            style: AppTextStyles.displaySmall(
                                _colorScheme.onPrimary),
                          ),
                          GestureDetector(
                            onTap: () => context.router.push(AddRecipeRoute()),
                            child: Icon(
                              Icons.add_circle,
                              size: 30,
                              color: _colorScheme.surfaceContainer,
                            ),
                          ),
                        ],
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        style: AppTextStyles.bodyMedium(_colorScheme.secondary),
                        controller: searchController,
                        maxLines: 1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(14.0)),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(14.0)),
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
                    return ListView.separated(
                      padding: EdgeInsets.all(16),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.recipes.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 15),
                      itemBuilder: (context, index) {
                        final recipe = state.recipes[index];
                        return Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _colorScheme.onPrimary,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      recipe.name,
                                      style: AppTextStyles.bodyMedium(
                                          _colorScheme.secondary),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '${recipe.calories} kcal',
                                      style: AppTextStyles.bodySmall(
                                          _colorScheme.secondary
                                              .withOpacity(.6)),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      '${recipe.time.hour} h ${recipe.time.minute} min',
                                      style: AppTextStyles.bodySmall(
                                          _colorScheme.secondary
                                              .withOpacity(.6)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 12),
                              GestureDetector(
                                  onTap: () => showCupertinoModalPopup<void>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            CupertinoActionSheet(
                                          actions: <CupertinoActionSheetAction>[
                                            CupertinoActionSheetAction(
                                              onPressed: () {
                                                context.router.push(
                                                    EditRecipeRoute(
                                                        recipe: recipe));
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'Edit',
                                                style: AppTextStyles.bodyMedium(
                                                    _colorScheme.secondary),
                                              ),
                                            ),
                                            CupertinoActionSheetAction(
                                              onPressed: () {
                                                setState(() {
                                                  context
                                                      .read<RecipeBloc>()
                                                      .add(DeleteRecipeEvent(
                                                          recipe: recipe));
                                                  context
                                                      .read<RecipeBloc>()
                                                      .add(GetRecipesEvent());
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'Delete',
                                                style: AppTextStyles.bodyMedium(
                                                    _colorScheme.error),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  child: Icon(
                                    Icons.more_vert,
                                    color: _colorScheme.surfaceContainer,
                                  ))
                            ],
                          ),
                        );
                      },
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
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
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
}
