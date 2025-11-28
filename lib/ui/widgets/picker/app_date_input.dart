import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/common/app_colors.dart';
import 'package:todo_app/common/app_text_style.dart';
import 'package:todo_app/ui/widgets/picker/app_date_picker.dart';
import 'package:todo_app/utils/app_date_util.dart';

class AppDateInput extends StatelessWidget {
  final TextEditingController controller;
  final String? dateFormat;
  final String hintText;
  final String title;
  final String assetIcon;
  final String? Function(String?)? validator;
  final bool? isTime;

  const AppDateInput({
    super.key,
    required this.controller,
    this.dateFormat,
    required this.hintText,
    required this.title,
    required this.assetIcon,
    this.validator,
    this.isTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(title, style: AppTextStyles.bSmallSemiBold),

        TextFormField(
          controller: controller,
          readOnly: true,
          style: AppTextStyles.bMedium,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
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
            suffixIcon: SvgPicture.asset(
              assetIcon,
              width: 20,
              height: 20,
              fit: BoxFit.scaleDown,
            ),
          ),
          onTap: () async {
            if (isTime == true) {
              await _selectTime(context);
            } else {
              await _selectDate(context);
            }
          },
          validator: validator,
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final date = controller.text.isNotEmpty
        ? AppDateUtil.fromDateString(controller.text, format: dateFormat)
        : DateTime.now();
    final pickDate = await AppDatePicker.pickDate(context, initialDate: date);
    if (pickDate != null) {
      controller.text = AppDateUtil.toDatePickerString(pickDate);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final time = controller.text.isNotEmpty
        ? AppDateUtil.formTimeString(controller.text, format: dateFormat)
        : TimeOfDay.now();
    final pickTime = await AppDatePicker.pickTime(context, initialTime: time);
    if (pickTime != null) {
      controller.text = AppDateUtil.timeOfDayToString(
        pickTime,
        format: dateFormat,
      );
    }
  }
}
