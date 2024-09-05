import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pp_463/theme/textstyles.dart';

class AppTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hintText;
  final int? maxLines;
  final Icon? suffixIcon;
  final bool readOnly;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onTap;

  AppTextField({
    super.key,
    required this.title,
    required this.controller,
    required this.hintText,
    this.maxLines,
    this.suffixIcon,
    required this.readOnly,
    required this.keyboardType,
    this.inputFormatters,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final _colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.displaySmall(_colorScheme.secondary),
        ),
        SizedBox(height: 10),
        TextField(
          onTap: onTap,
          readOnly: readOnly,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          maxLines: maxLines,
          style: AppTextStyles.bodyMedium(_colorScheme.secondary),
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16),
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: AppTextStyles.bodyMedium(_colorScheme.secondary.withOpacity(.4)),
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
      ],
    );
  }
}
