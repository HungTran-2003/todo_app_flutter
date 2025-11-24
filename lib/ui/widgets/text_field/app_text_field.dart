import 'package:flutter/material.dart';
import 'package:todo_app/common/app_colors.dart';
import 'package:todo_app/common/app_text_style.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final String hint;
  final bool? enabled;
  final String? assetIcon;
  final int? maxLines;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.hint,
    this.assetIcon,
    this.enabled = true,
    this.maxLines = 1,
    this.validator,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          widget.title, style: AppTextStyles.bSmallSemiBold,
        ),

        Expanded(
          child: TextFormField(
            controller: widget.controller,
            enabled: widget.enabled,
            maxLines: widget.maxLines,
            expands: widget.maxLines == null ? true : false,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: widget.hint,
              hintStyle: AppTextStyles.bMedium.copyWith(
                  color: AppColors.textBlack.withValues(alpha: 0.7)
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                borderSide: BorderSide(color: AppColors.tfBorder, width: 1.0),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                borderSide: BorderSide(color: AppColors.tfBorder, width: 1.0),
              ),
              disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                borderSide: BorderSide(color: AppColors.tfBorder, width: 1.0),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                borderSide: BorderSide(color: AppColors.error, width: 1.0),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                borderSide: BorderSide(color: AppColors.error, width: 1.0),
              ),
            ),
            validator: widget.validator,
          ),
        )
      ],
    );
  }
}
