import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pp_463/data/models/ration_type.dart';
import 'package:pp_463/data/models/recipe.dart';
import 'package:pp_463/helpers/date_helper.dart';
import 'package:pp_463/router/router.dart';
import 'package:pp_463/screens/ration/ration_bloc/ration_bloc.dart';
import 'package:pp_463/screens/statistic/statistic_bloc/statistic_bloc.dart';
import 'package:pp_463/theme/textstyles.dart';
import 'package:pp_463/theme/theme.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DateTime _currentDate = DateTime.now();

  void _init() {
    context.read<RationBloc>().add(GetRationEvent(date: _currentDate));
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _colorScheme = Theme.of(context).colorScheme;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: _colorScheme.background,
        body: SingleChildScrollView(
          child: BlocBuilder<RationBloc, RationState>(
            builder: (context, state) {
              if (state is LoadRationState) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/elements/appbar-bg.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      height: MediaQuery.of(context).size.height * .32,
                      width: MediaQuery.of(context).size.width,
                      child: SafeArea(
                        bottom: false,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'HI!',
                                        style: AppTextStyles.displayLarge(
                                            _colorScheme.onPrimary),
                                      ),
                                      Text(
                                        'What are you cooking today',
                                        style: AppTextStyles.bodyMedium(
                                            _colorScheme.onPrimary),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => context.router.push(StatisticDetailsRoute()),
                                      child: Icon(
                                        Icons.bar_chart,
                                        size: 25,
                                        color: _colorScheme.onPrimary,
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    GestureDetector(
                                      onTap: () => context.router.push(SettingsListRoute()),
                                      child: Icon(
                                        Icons.settings,
                                        size: 25,
                                        color: _colorScheme.onPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Center(
                                  child: Text(
                                    'Statistics',
                                    style: AppTextStyles.displaySmall(
                                        _colorScheme.onPrimary),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: _colorScheme.onPrimary,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Carbs',
                                              style:
                                              AppTextStyles.bodySmall(
                                                  _colorScheme
                                                      .secondary),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(vertical: 5.0),
                                              child: LinearPercentIndicator(
                                                animation: false,
                                                lineHeight: 6,
                                                percent: state.carbsRate <= 1 ? state.carbsRate : 1,
                                                linearStrokeCap:
                                                LinearStrokeCap
                                                    .roundAll,
                                                barRadius:
                                                Radius.circular(16),
                                                backgroundColor:
                                                _colorScheme.outline,
                                                progressColor:
                                                AppColors.red,
                                              ),
                                            ),
                                            Text(
                                              '${state.carbs} g',
                                              style:
                                              AppTextStyles.bodySmall(
                                                  _colorScheme
                                                      .secondary),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Protein',
                                              style:
                                              AppTextStyles.bodySmall(
                                                  _colorScheme
                                                      .secondary),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(vertical: 5.0),
                                              child: LinearPercentIndicator(
                                                animation: false,
                                                lineHeight: 6,
                                                percent: state.proteinRate <= 1 ? state.proteinRate : 1,
                                                linearStrokeCap:
                                                LinearStrokeCap
                                                    .roundAll,
                                                barRadius:
                                                Radius.circular(16),
                                                backgroundColor:
                                                _colorScheme.outline,
                                                progressColor:
                                                AppColors.yellow,
                                              ),
                                            ),
                                            Text(
                                              '${state.protein} g',
                                              style:
                                              AppTextStyles.bodySmall(
                                                  _colorScheme
                                                      .secondary),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Fats',
                                              style:
                                              AppTextStyles.bodySmall(
                                                  _colorScheme
                                                      .secondary),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(vertical: 5.0),
                                              child: LinearPercentIndicator(
                                                animation: false,
                                                lineHeight: 6,
                                                percent: state.fatsRate <= 1 ? state.fatsRate : 1,
                                                linearStrokeCap:
                                                LinearStrokeCap
                                                    .roundAll,
                                                barRadius:
                                                Radius.circular(16),
                                                backgroundColor:
                                                _colorScheme.outline,
                                                progressColor:
                                                AppColors.purple,
                                              ),
                                            ),
                                            Text(
                                              '${state.fats} g',
                                              style:
                                              AppTextStyles.bodySmall(
                                                  _colorScheme
                                                      .secondary),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Center(
                            child: GestureDetector(
                              onTap: () => _showDialog(CupertinoDatePicker(
                                initialDateTime: _currentDate,
                                mode: CupertinoDatePickerMode.date,
                                use24hFormat: true,
                                showDayOfWeek: true,
                                onDateTimeChanged: (DateTime newDate) {
                                  setState(() {
                                    _currentDate = newDate;
                                    context.read<RationBloc>().add(
                                        GetRationEvent(date: _currentDate));
                                  });
                                },
                              )),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.calendar_month_rounded,
                                    color: _colorScheme.secondary,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    DateHelper.formatInTextDate(_currentDate),
                                    style: AppTextStyles.bodyMedium(
                                        _colorScheme.secondary),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          MealTile(
                            imagePath: 'assets/images/elements/breakfast.png',
                            type: RationType.breakfast,
                            recipes: state.ration.breakfast,
                            onTap: () => context.router.push(RecipeListRoute(
                              ration: state.ration,
                              type: RationType.breakfast,
                              recipes: state.ration.breakfast,
                            )),
                          ),
                          SizedBox(height: 15),
                          MealTile(
                            imagePath: 'assets/images/elements/lunch.png',
                            type: RationType.lunch,
                            recipes: state.ration.lunch,
                           onTap: () => context.router.push(RecipeListRoute(
                              ration: state.ration,
                              type: RationType.lunch,
                              recipes: state.ration.lunch,
                            )),
                          ),
                          SizedBox(height: 15),
                          MealTile(
                            imagePath: 'assets/images/elements/dinner.png',
                            type: RationType.dinner,
                            recipes: state.ration.dinner,
                            onTap: () => context.router.push(RecipeListRoute(
                              ration: state.ration,
                              type: RationType.dinner,
                              recipes: state.ration.dinner,
                            )),
                          ),
                          SizedBox(height: 15),
                          MealTile(
                            imagePath: 'assets/images/elements/snack.png',
                            type: RationType.snack,
                            recipes: state.ration.snack,
                            onTap: () => context.router.push(RecipeListRoute(
                              ration: state.ration,
                              type: RationType.snack,
                              recipes: state.ration.snack,
                            )),
                          ),
                          SizedBox(height: 15),
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: _colorScheme.onPrimary,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 8),
                                Image.asset(
                                  'assets/images/elements/water.png',
                                  width: 40,
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Water',
                                        style: AppTextStyles.displaySmall(
                                            _colorScheme.secondary),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        '${state.ration.water} L',
                                        style: AppTextStyles.displaySmall(
                                            _colorScheme.secondary),
                                      )
                                    ],
                                  ),
                                ),
                                CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () => setState(() {
                                    context.read<RationBloc>().add(
                                        DecrementWaterEvent(
                                            ration: state.ration));
                                  }),
                                  child: Icon(
                                    Icons.remove_circle_outline,
                                    size: 30,
                                    color: AppColors.blue,
                                  ),
                                ),
                                CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () => setState(() {
                                    context.read<RationBloc>().add(
                                        IncrementWaterEvent(
                                            ration: state.ration));
                                  }),
                                  child: Icon(
                                    Icons.add_circle_outline,
                                    size: 30,
                                    color: AppColors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 70),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }
}

class MealTile extends StatelessWidget {
  final String imagePath;
  final RationType type;
  final List<Recipe> recipes;
  final void Function()? onTap;

  const MealTile(
      {super.key,
      required this.imagePath,
      required this.type,
      required this.recipes,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final _colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                imagePath,
                width: 60,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      type.label,
                      style: AppTextStyles.displaySmall(_colorScheme.secondary),
                    ),
                    SizedBox(height: 5),
                    recipes.isEmpty
                        ? Text(
                            '0 kcal',
                            style: AppTextStyles.bodyMedium(
                                _colorScheme.secondary.withOpacity(.4)),
                          )
                        : ListView.separated(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: recipes.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    SizedBox(height: 5),
                            itemBuilder: (context, index) {
                              final recipe = recipes[index];
                              return Text(
                                recipe.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.bodyMedium(
                                    _colorScheme.secondary.withOpacity(.4)),
                              );
                            },
                          )
                  ],
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _colorScheme.surfaceContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    size: 27,
                    color: AppColors.yellow,
                  ),
                ),
              ),
            ],
          ),
          recipes.isNotEmpty
              ? Column(
                  children: [
                    Divider(
                      thickness: 1,
                      color: _colorScheme.secondary.withOpacity(.2),
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        '${recipes.fold(0, (prev, recipe) => prev + recipe.calories)} kcal',
                        style: AppTextStyles.bodyMedium(
                            _colorScheme.secondary.withOpacity(.4)),
                      ),
                    )
                  ],
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
