import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pp_463/data/models/nutrition.dart';
import 'package:pp_463/router/router.dart';
import 'package:pp_463/screens/statistic/statistic_bloc/statistic_bloc.dart';
import 'package:pp_463/theme/textstyles.dart';
import 'package:pp_463/widgets/app_action_button.dart';
import 'package:pp_463/widgets/app_text_field.dart';

@RoutePage()
class UpdateNutritionScreen extends StatefulWidget {
  final Nutrition nutrition;

  const UpdateNutritionScreen({super.key, required this.nutrition});

  @override
  State<UpdateNutritionScreen> createState() => _UpdateNutritionScreenState();
}

class _UpdateNutritionScreenState extends State<UpdateNutritionScreen> {
  late final carbsController;
  late final proteinController;
  late final fatsController;
  late final caloriesController;

  void _init() {
    carbsController = TextEditingController()
      ..text = widget.nutrition.carbs.toString();
    proteinController = TextEditingController()
      ..text = widget.nutrition.protein.toString();
    fatsController = TextEditingController()
      ..text = widget.nutrition.fats.toString();
    caloriesController = TextEditingController()
      ..text = widget.nutrition.calories.toString();
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    carbsController.dispose();
    proteinController.dispose();
    fatsController.dispose();
    caloriesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: _colorScheme.background,
      appBar: AppBar(
        backgroundColor: _colorScheme.background,
        foregroundColor: _colorScheme.secondary,
        centerTitle: true,
        title: Text(
          'Update a nutrition',
          style: AppTextStyles.displaySmall(
            _colorScheme.secondary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              AppTextField(
                title: 'Carbs',
                controller: carbsController,
                hintText: '0 g',
                readOnly: false,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 15),
              AppTextField(
                title: 'Protein',
                controller: proteinController,
                hintText: '0 g',
                readOnly: false,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 15),
              AppTextField(
                title: 'Fats',
                controller: fatsController,
                hintText: '0 g',
                readOnly: false,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 15),
              AppTextField(
                title: 'Calories',
                controller: caloriesController,
                hintText: '0 kcal',
                readOnly: false,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 25),
              AppActionButton(
                text: 'Save',
                onPressed: () => _onSave(),
                width: double.infinity,
              ),
              SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
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

  void _onSave() {
    if (carbsController.text.isNotEmpty &&
        proteinController.text.isNotEmpty &&
        fatsController.text.isNotEmpty &&
        caloriesController.text.isNotEmpty) {
      Nutrition editNutrition = Nutrition(
        carbs: int.parse(carbsController.text),
        protein: int.parse(proteinController.text),
        fats: int.parse(fatsController.text),
        calories: int.parse(caloriesController.text),
      );
      context
          .read<StatisticBloc>()
          .add(UpdateNutritionEvent(nutrition: editNutrition));
      context.router.push(MainRoute());
    } else {
      _showFailedSnackBar('Incorrect information');
    }
  }
}
