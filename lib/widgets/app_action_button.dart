import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pp_463/theme/textstyles.dart';

class AppActionButton extends StatelessWidget {
  final String text;
  final double width;
  final void Function()? onPressed;

  const AppActionButton(
      {super.key,
        required this.text,
        required this.onPressed, required this.width});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        height: 60,
        width: width,
        decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .primary,
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Center(
          child: Text(
              text,
              style: AppTextStyles.displaySmall(Theme.of(context).colorScheme.onPrimary)
          ),
        ),
      ),
    );
  }
}