import 'package:flutter/material.dart';
import 'package:todo_app/common/app_colors.dart';

class SimplePageIndicator extends StatelessWidget {
  final int pageCount;
  final int currentPage;

  const SimplePageIndicator({
    super.key,
    required this.pageCount,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        return _buildIndicator(index == currentPage);
      }),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 4.0,
      width: 26.0,
      decoration: BoxDecoration(
        color: isActive ? AppColors.indicatorBlack : AppColors.indicatorGray,
        borderRadius: BorderRadius.circular(56.0),
      ),
    );
  }
}