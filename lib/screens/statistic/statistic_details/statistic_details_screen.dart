import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pp_463/router/router.dart';
import 'package:pp_463/screens/statistic/statistic_bloc/statistic_bloc.dart';
import 'package:pp_463/theme/textstyles.dart';
import 'package:pp_463/widgets/app_action_button.dart';

@RoutePage()
class StatisticDetailsScreen extends StatefulWidget {
  const StatisticDetailsScreen({super.key});

  @override
  State<StatisticDetailsScreen> createState() => _StatisticDetailsScreenState();
}

class _StatisticDetailsScreenState extends State<StatisticDetailsScreen> {
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
              height: MediaQuery.of(context).size.height * .17,
              width: MediaQuery.of(context).size.width,
              child: SafeArea(
                bottom: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => context.router.navigate(MainRoute()),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: _colorScheme.onPrimary,
                      ),
                    ),
                    Text(
                      'Progress',
                      style: AppTextStyles.bodyLarge(_colorScheme.onPrimary),
                    ),
                    SizedBox(width: 30),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weekly progress',
                    style: AppTextStyles.displaySmall(_colorScheme.secondary),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: BlocProvider(
                      create: (context) =>
                          StatisticBloc()..add(GetWeeklyProgressEvent()),
                      child: BlocBuilder<StatisticBloc, StatisticState>(
                        builder: (context, state) {
                          if (state is LoadWeeklyProgressState) {
                            return Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Optimally',
                                    style: AppTextStyles.bodySmall(
                                        _colorScheme.secondary),
                                  ),
                                  SizedBox(width: 10),
                                  CircularPercentIndicator(
                                    radius: 80.0,
                                    lineWidth: 17.0,
                                    animation: true,
                                    percent: state.rate <= 1 ? state.rate : 1,
                                    center: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          color: _colorScheme.surfaceContainer,
                                          shape: BoxShape.circle),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              state.kcal.toString(),
                                              textAlign: TextAlign.center,
                                              style: AppTextStyles.bodyLarge(
                                                  _colorScheme.secondary),
                                            ),
                                            Text(
                                              'kcal',
                                              textAlign: TextAlign.center,
                                              style: AppTextStyles.displaySmall(
                                                  _colorScheme.secondary),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    footer: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        "Good",
                                        style: AppTextStyles.bodySmall(
                                            _colorScheme.secondary),
                                      ),
                                    ),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    progressColor: _colorScheme.primary,
                                    backgroundColor:
                                        _colorScheme.surfaceContainer,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Disbalance',
                                    style: AppTextStyles.bodySmall(
                                        _colorScheme.secondary),
                                  ),
                                ],
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        'Nutrition',
                        style:
                            AppTextStyles.displaySmall(_colorScheme.secondary),
                      ),
                      SizedBox(width: 5),
                      Text(
                        '(Calculate and record the values)',
                        style: AppTextStyles.bodyMedium(
                            _colorScheme.secondary.withOpacity(.4)),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: BlocProvider(
                      create: (context) =>
                          StatisticBloc()..add(GetNutritionEvent()),
                      child: BlocBuilder<StatisticBloc, StatisticState>(
                        builder: (context, state) {
                          if (state is LoadNutritionState) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'How many total calories per day',
                                  style: AppTextStyles.bodyMedium(
                                      _colorScheme.secondary),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: _colorScheme.surfaceContainer,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Calories',
                                          style: AppTextStyles.bodyMedium(
                                              _colorScheme.secondary),
                                        ),
                                      ),
                                      Text(
                                        '${state.nutrition.calories.toString()} Kcal',
                                        style: AppTextStyles.bodyMedium(
                                            _colorScheme.secondary),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  'How many total carbs/protein and fats per day',
                                  style: AppTextStyles.bodyMedium(
                                      _colorScheme.secondary),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: _colorScheme.surfaceContainer,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Carbs',
                                          style: AppTextStyles.bodyMedium(
                                              _colorScheme.secondary),
                                        ),
                                      ),
                                      Text(
                                        '${state.nutrition.carbs.toString()} G',
                                        style: AppTextStyles.bodyMedium(
                                            _colorScheme.secondary),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: _colorScheme.surfaceContainer,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Protein',
                                          style: AppTextStyles.bodyMedium(
                                              _colorScheme.secondary),
                                        ),
                                      ),
                                      Text(
                                        '${state.nutrition.protein.toString()} G',
                                        style: AppTextStyles.bodyMedium(
                                            _colorScheme.secondary),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: _colorScheme.surfaceContainer,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Fats',
                                          style: AppTextStyles.bodyMedium(
                                              _colorScheme.secondary),
                                        ),
                                      ),
                                      Text(
                                        '${state.nutrition.fats.toString()} G',
                                        style: AppTextStyles.bodyMedium(
                                            _colorScheme.secondary),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                AppActionButton(
                                  text: 'Update Nutrition',
                                  onPressed: () => context.router
                                      .push(UpdateNutritionRoute(nutrition: state.nutrition)),
                                  width: double.infinity,
                                ),

                              ],
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 70),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
