import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pratical_task_app/core/constants/app_colors.dart';

class TitleValueItemWidget extends StatelessWidget {
  final String title;
  final String value;
  final double? titleFontSize;
  final double? gap;

  const TitleValueItemWidget({
    super.key,
    required this.title,
    required this.value,
    this.titleFontSize,
    this.gap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(height: gap ?? 5.h),
        Text(
          title,
          style: TextStyle(
            fontSize: titleFontSize ?? 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}

