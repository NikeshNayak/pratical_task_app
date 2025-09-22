import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pratical_task_app/core/constants/app_colors.dart';

class NotesInputItemWidget extends StatefulWidget {
  final String title;
  final String? iconPath;
  final double? iconWidth;
  final double? iconHeight;
  final void Function(String)? onChanged;

  const NotesInputItemWidget({
    super.key,
    required this.title,
    this.iconPath,
    this.iconWidth,
    this.iconHeight,
    this.onChanged,
  });

  @override
  State<NotesInputItemWidget> createState() => _NotesInputItemWidgetState();
}

class _NotesInputItemWidgetState extends State<NotesInputItemWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (widget.onChanged != null) {
        widget.onChanged!(_controller.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.iconPath != null)
              SvgPicture.asset(
                widget.iconPath!,
                height: widget.iconHeight,
                width: widget.iconWidth,
                colorFilter: const ColorFilter.mode(
                  AppColors.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
            SizedBox(width: 12.w),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 20.sp,
                height: 24.sp / 20.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Add Notes',
            hintStyle: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.dividerColor3,
            ),
            border: InputBorder.none,
          ),
          style: TextStyle(fontSize: 14.sp, height: 20.sp / 14.sp),
        ),
      ],
    );
  }
}

