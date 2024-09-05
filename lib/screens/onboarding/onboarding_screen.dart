import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pp_463/router/router.dart';
import 'package:pp_463/theme/textstyles.dart';
import 'package:pp_463/widgets/app_action_button.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final controller;
  bool isLastPage = false;

  void _init() {
    controller = PageController();
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _checkLastPage(int index) {
    setState(() {
      isLastPage = index == 2;
    });
  }

  void _nextPage() {
    controller.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void _onButton() {
    if (isLastPage) {
      context.router.push(MainRoute());
    } else {
      _nextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _colorScheme = Theme.of(context).colorScheme;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: _colorScheme.background,
        body: PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) => _checkLastPage(index),
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/onboarding/1.png"),
                  fit: BoxFit.cover,
                ),
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(flex: 3),
                  Text(
                    'Your recipes, your meal plan'.toUpperCase(),
                    textAlign: TextAlign.start,
                    style: AppTextStyles.displayLarge(_colorScheme.secondary),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Everything you need for delicious and healthy eating',
                    textAlign: TextAlign.start,
                    style: AppTextStyles.bodyMedium(_colorScheme.secondary),
                  ),
                  Spacer(flex: 1),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/onboarding/2.png"),
                  fit: BoxFit.cover,
                ),
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(flex: 3),
                  Text(
                    'Easily plan and cook with joy'.toUpperCase(),
                    textAlign: TextAlign.start,
                    style: AppTextStyles.displayLarge(_colorScheme.secondary),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Save favorite recipes and share with friends',
                    textAlign: TextAlign.start,
                    style: AppTextStyles.bodyMedium(_colorScheme.secondary),
                  ),
                  Spacer(flex: 1),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/onboarding/3.png"),
                  fit: BoxFit.cover,
                ),
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(flex: 3),
                  Text(
                    'Manage recipes, track your diet'.toUpperCase(),
                    textAlign: TextAlign.start,
                    style: AppTextStyles.displayLarge(_colorScheme.secondary),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Plan your meals and track your nutrition with ease',
                    textAlign: TextAlign.start,
                    style: AppTextStyles.bodyMedium(_colorScheme.secondary),
                  ),
                  Spacer(flex: 1),
                ],
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(16),
          child: AppActionButton(
            text: isLastPage ? 'Get started' : 'Continue',
            width: double.infinity,
            onPressed: () => _onButton(),
          ),
        ),
      ),
    );
  }
}
