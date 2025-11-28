import 'package:flutter/material.dart';
import 'package:todo_app/common/app_colors.dart';
import 'package:todo_app/common/app_text_style.dart';

class AppPasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final String hint;
  final double? height;
  final String? Function(String?)? validator;

  const AppPasswordTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.hint,
    this.validator,
    this.height,
  });

  @override
  State<AppPasswordTextField> createState() => _AppPasswordTextFieldState();
}

class _AppPasswordTextFieldState extends State<AppPasswordTextField> {
  bool _isObscured = true;
  void _toggleObscured() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(widget.title, style: AppTextStyles.bSmallSemiBold),
        SizedBox(
          height: widget.height,
          child: TextFormField(
            controller: widget.controller,
            style: AppTextStyles.bMedium,
            textAlignVertical: TextAlignVertical.top,
            obscureText: _isObscured,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: widget.hint,
              hintStyle: AppTextStyles.bMedium.copyWith(
                color: AppColors.textBlack.withValues(alpha: 0.7),
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
              suffixIcon: IconButton(
                onPressed: _toggleObscured,
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
            validator: widget.validator,
          ),
        ),
      ],
    );
  }
}
