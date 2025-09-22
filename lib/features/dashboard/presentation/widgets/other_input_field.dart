import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pratical_task_app/core/constants/app_colors.dart';

class OtherInputFieldWidget extends StatefulWidget {
  final String title;
  final String? iconPath;
  final double? iconWidth;
  final double? iconHeight;
  final void Function(String)? onChanged;

  const OtherInputFieldWidget({
    super.key,
    required this.title,
    this.iconPath,
    this.iconWidth,
    this.iconHeight,
    this.onChanged,
  });

  @override
  State<OtherInputFieldWidget> createState() => _OtherInputFieldWidgetState();
}

class _OtherInputFieldWidgetState extends State<OtherInputFieldWidget> {
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
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
              if (widget.iconPath != null)
                Row(
                  children: [
                    SizedBox(width: 8.w),
                    SvgPicture.asset(
                      widget.iconPath!,
                      height: widget.iconHeight,
                      width: widget.iconWidth,
                      colorFilter: const ColorFilter.mode(
                        AppColors.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          flex: 1,
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Enter',
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.darkGreyColor,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

