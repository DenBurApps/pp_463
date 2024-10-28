import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:pp_463/helpers/dialog_helper.dart';
import 'package:pp_463/helpers/email_helper.dart';
import 'package:pp_463/router/router.dart';
import 'package:pp_463/screens/settings/agreement_screen.dart';
import 'package:pp_463/theme/textstyles.dart';
import 'package:pp_463/widgets/app_action_button.dart';

@RoutePage()
class SettingsListScreen extends StatefulWidget {
  const SettingsListScreen({super.key});

  @override
  State<SettingsListScreen> createState() => _SettingsListScreenState();
}

class _SettingsListScreenState extends State<SettingsListScreen> {
  Future<void> _rate() async {
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      await inAppReview.requestReview();
    }
  }

  void _showAppVersionDialog(BuildContext context) =>
      DialogHelper.showAppVersionDialog(context);

  void _showContactTable(BuildContext context) {
    final subjectController = TextEditingController();
    final textController = TextEditingController();
    var buttonState = false;

    Future<void> send() async => await EmailHelper.launchEmailSubmission(
          toEmail: 'abidanaz@promhelp.space',
          subject: subjectController.text,
          body: textController.text,
          errorCallback: () {},
          doneCallback: () {},
        );

    DialogHelper.showCustomModalPopup(context, StatefulBuilder(
      builder: (BuildContext context, Function(Function()) setState) {
        void updateButtonState() {
          if (subjectController.text.isNotEmpty &&
              textController.text.isNotEmpty) {
            setState(
              () => buttonState = true,
            );
          } else {
            setState(
              () => buttonState = false,
            );
          }
        }

        subjectController.addListener(updateButtonState);
        textController.addListener(updateButtonState);

        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(34),
                topLeft: Radius.circular(34),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    'Contact us',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 20),
                AppTextField(
                    controller: subjectController,
                    placeholder: 'Message subject'),
                const SizedBox(height: 20),
                AppTextField(
                    controller: textController, placeholder: 'Message text'),
                const SizedBox(height: 40),
                Center(
                  child: AppActionButton(
                    text: 'Send',
                    width: double.infinity,
                    onPressed: buttonState ? send : null,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ));
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
                      'Settings',
                      style: AppTextStyles.bodyLarge(_colorScheme.onPrimary),
                    ),
                    SizedBox(width: 30),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Feedback and support',
                    textAlign: TextAlign.start,
                    style: AppTextStyles.bodyMedium(
                        _colorScheme.secondary.withOpacity(.4)),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: _colorScheme.surface,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        CupertinoButton(
                          padding: EdgeInsets.all(16),
                          onPressed: () => _showContactTable(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Contact Us',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.displaySmall(
                                    _colorScheme.secondary),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20,
                                color: _colorScheme.primaryContainer,
                              ),
                            ],
                          ),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.all(16),
                          onPressed: _rate,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rate app',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.displaySmall(
                                    _colorScheme.secondary),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20,
                                color: _colorScheme.primaryContainer,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'About the program',
                    textAlign: TextAlign.start,
                    style: AppTextStyles.bodyMedium(
                        _colorScheme.secondary.withOpacity(.4)),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: _colorScheme.surface,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        CupertinoButton(
                          padding: EdgeInsets.all(16),
                          onPressed: () => _showAppVersionDialog(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Version',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.displaySmall(
                                    _colorScheme.secondary),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20,
                                color: _colorScheme.primaryContainer,
                              ),
                            ],
                          ),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.all(16),
                          onPressed: () => context.router.push(AgreementRoute(
                              arguments: AgreementViewArguments(
                                  agreementType: AgreementType.privacy))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Privacy Policy',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.displaySmall(
                                    _colorScheme.secondary),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20,
                                color: _colorScheme.primaryContainer,
                              ),
                            ],
                          ),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.all(16),
                          onPressed: () => context.router.push(AgreementRoute(
                              arguments: AgreementViewArguments(
                                  agreementType: AgreementType.terms))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Terms of Use',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.displaySmall(
                                    _colorScheme.secondary),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20,
                                color: _colorScheme.primaryContainer,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.placeholder,
    this.prefix,
    this.suffix,
    this.borderColor,
    this.bgColor,
    this.maxLength,
    this.maxLines,
    this.onChanged,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String placeholder;
  final Widget? prefix;
  final Widget? suffix;
  final Color? borderColor;
  final Color? bgColor;
  final int? maxLength;
  final int? maxLines;
  final TextInputType? keyboardType;
  final Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      keyboardType: keyboardType,
      suffix: suffix,
      prefix: prefix,
      maxLength: maxLength ?? 16,
      maxLines: maxLines ?? 1,
      placeholder: placeholder,
      onChanged: onChanged,
      padding: const EdgeInsets.all(15),
      placeholderStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.5)),
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.secondary,
          ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}
