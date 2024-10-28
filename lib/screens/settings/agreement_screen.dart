
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pp_463/helpers/email_helper.dart';
import 'package:pp_463/helpers/text_helper.dart';
import 'package:pp_463/router/router.dart';
import 'package:pp_463/widgets/app_action_button.dart';

enum AgreementType {
  privacy,
  terms,
}

class AgreementViewArguments {
  final AgreementType agreementType;
  final bool usePrivacyAgreement;

  AgreementViewArguments({
    required this.agreementType,
    this.usePrivacyAgreement = false,
  });
}

@RoutePage()
class AgreementScreen extends StatefulWidget {
  final AgreementViewArguments arguments;

  const AgreementScreen({super.key, required this.arguments});

  factory AgreementScreen.create(BuildContext context) {
    final arguments =
    ModalRoute.of(context)!.settings.arguments as AgreementViewArguments;
    return AgreementScreen(arguments: arguments);
  }

  @override
  State<AgreementScreen> createState() => _AgreementScreenState();
}

class _AgreementScreenState extends State<AgreementScreen> {
  AgreementType get _agreementType => widget.arguments.agreementType;

  bool get _usePrivacyAgreement => widget.arguments.usePrivacyAgreement;

  String get _agreementText => _agreementType == AgreementType.privacy
      ? TextHelper.privacy
      : TextHelper.terms;

  String get _title => _agreementType == AgreementType.privacy
      ? 'Privacy Policy'
      : 'Terms Of Use';

  void _accept() {
    context.router.push(MainRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_usePrivacyAgreement)
                      Text(
                        _title,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      )
                    else
                      CupertinoButton(
                          child: Icon(Icons.arrow_back_ios,
                              color: Theme.of(context).colorScheme.primary),
                          onPressed: () {
                            context.router.navigate(SettingsListRoute());
                          }),
                    const SizedBox(height: 14),
                    Text(
                      _agreementType == AgreementType.privacy
                          ? 'Privacy Policy'
                          : 'Terms of Use',
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(height: 13),
                    Expanded(
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(
                            bottom: _usePrivacyAgreement ? 90 : 60,
                          ),
                          physics: const BouncingScrollPhysics(),
                          child: MarkdownBody(
                            styleSheet: MarkdownStyleSheet(
                              p: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.8),
                              ),
                              a: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.8),
                              ),
                              code: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.8),
                              ),
                              checkbox: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.8),
                              ),
                              em: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.8),
                              ),
                              del: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.8),
                              ),
                              listBullet: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.8),
                              ),
                              h1: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.8),
                              ),
                              h2: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.8),
                              ),
                              h3: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.8)),
                              h4: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.8),
                              ),
                            ),
                            data: _agreementText,
                            onTapLink: (text, href, title) =>
                                EmailHelper.launchEmailSubmission(
                                  toEmail: 'abidanaz@promhelp.space',
                                  subject: '',
                                  body: '',
                                  errorCallback: () {},
                                  doneCallback: () {},
                                ),
                            selectable: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (_usePrivacyAgreement)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AppActionButton(
                      width: double.infinity,
                      text: 'Accept app privacy',
                      onPressed: _accept,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
