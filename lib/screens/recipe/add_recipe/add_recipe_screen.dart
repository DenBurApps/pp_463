import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pp_463/data/models/recipe.dart';
import 'package:pp_463/helpers/date_helper.dart';
import 'package:pp_463/router/router.dart';
import 'package:pp_463/screens/recipe/recipe_bloc/recipe_bloc.dart';
import 'package:pp_463/theme/textstyles.dart';
import 'package:pp_463/theme/theme.dart';
import 'package:pp_463/widgets/app_action_button.dart';
import 'package:pp_463/widgets/app_text_field.dart';

@RoutePage()
class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  late final nameController;

  DateTime time = DateTime(1, 1, 0, 0, 0);
  late final timeController;

  late final ingredientController;
  List<String> ingredients = [];

  late final carbsController;
  late final proteinController;
  late final fatsController;
  late final caloriesController;

  void _init() {
    nameController = TextEditingController();
    timeController = TextEditingController()
      ..text = DateHelper.formatTime(time);
    ingredientController = TextEditingController();
    carbsController = TextEditingController();
    proteinController = TextEditingController();
    fatsController = TextEditingController();
    caloriesController = TextEditingController();
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    timeController.dispose();
    ingredientController.dispose();
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
          'Creating a recipe',
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
                title: 'Name of recipe',
                controller: nameController,
                hintText: 'Name of recipe',
                readOnly: false,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 15),
              AppTextField(
                title: 'Cooking time',
                controller: timeController,
                hintText: 'HH/MM',
                readOnly: true,
                keyboardType: TextInputType.text,
                suffixIcon: Icon(
                  Icons.watch_later,
                  color: _colorScheme.primary,
                  size: 25,
                ),
                onTap: () => _showDialog(CupertinoDatePicker(
                  initialDateTime: time,
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: true,
                  showDayOfWeek: true,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      time = newDate;
                      timeController.text = DateHelper.formatTime(time);
                    });
                  },
                )),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _onAddIngredient(),
                    child: Icon(
                      Icons.add_circle_outline,
                      color: _colorScheme.primary,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      style: AppTextStyles.bodyMedium(_colorScheme.secondary),
                      controller: ingredientController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(16),
                        hintText: 'Add an ingredient',
                        hintStyle: AppTextStyles.bodyMedium(
                            _colorScheme.secondary.withOpacity(.4)),
                        filled: true,
                        fillColor: _colorScheme.surface,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              ingredients.isNotEmpty
                  ? ListView.separated(
                      padding: EdgeInsets.only(bottom: 15),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: ingredients.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 15),
                      itemBuilder: (context, index) {
                        final ingredient = ingredients[index];
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () => _onDeleteIngredient(ingredient),
                              child: Icon(
                                Icons.remove_circle_outline,
                                color: AppColors.red,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                                child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: _colorScheme.surface,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0)),
                              ),
                              child: Text(
                                ingredient,
                                style: AppTextStyles.bodyMedium(
                                    _colorScheme.secondary),
                              ),
                            )),
                          ],
                        );
                      },
                    )
                  : const SizedBox(),
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
                title: 'How many total calories',
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

  void _onAddIngredient() {
    if (ingredientController.text.isNotEmpty) {
      setState(() {
        ingredients.add(ingredientController.text);
      });
      ingredientController.clear();
    } else {
      _showFailedSnackBar('Incorrect information');
    }
  }

  void _onDeleteIngredient(String ingredient) {
    setState(() {
      ingredients.remove(ingredient);
    });
  }

  void _onSave() {
    if (nameController.text.isNotEmpty &&
        ingredients.isNotEmpty &&
        carbsController.text.isNotEmpty &&
        proteinController.text.isNotEmpty &&
        fatsController.text.isNotEmpty &&
        caloriesController.text.isNotEmpty) {
      Recipe newRecipe = Recipe(
        name: nameController.text,
        time: time,
        ingredients: ingredients,
        carbs: int.parse(carbsController.text),
        protein: int.parse(proteinController.text),
        fats: int.parse(fatsController.text),
        calories: int.parse(caloriesController.text),
      );
      context.read<RecipeBloc>().add(AddRecipeEvent(recipe: newRecipe));
      context.router.push(MainRoute());
    } else {
      _showFailedSnackBar('Incorrect information');
    }
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
