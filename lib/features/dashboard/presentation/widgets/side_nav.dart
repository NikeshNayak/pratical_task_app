import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pratical_task_app/core/constants/app_colors.dart';
import 'package:pratical_task_app/core/constants/assets.dart';

class SideNavItem {
  final String iconPath;
  final double iconHeight;
  final double iconWidth;
  final String? text;

  const SideNavItem({
    required this.iconPath,
    required this.iconHeight,
    required this.iconWidth,
    this.text,
  });
}

class SideNavigationMenu extends StatelessWidget {
  const SideNavigationMenu({super.key, this.onItemTap});

  final ValueChanged<int>? onItemTap;

  static final List<SideNavItem> items = <SideNavItem>[
    SideNavItem(iconPath: SVGPath.eatOSBigLogo, iconHeight: 28, iconWidth: 56),
    SideNavItem(
      iconPath: SVGPath.newOrderIcon,
      iconHeight: 36.37,
      iconWidth: 40,
    ),
    SideNavItem(iconPath: SVGPath.tableIcon, iconHeight: 40, iconWidth: 40),
    SideNavItem(
      iconPath: SVGPath.openTicketsIcon,
      iconHeight: 32.66,
      iconWidth: 40,
    ),
    SideNavItem(
      iconPath: SVGPath.orderOSIcon,
      iconHeight: 40,
      iconWidth: 47.56,
    ),
    SideNavItem(iconPath: SVGPath.chartIcon, iconHeight: 45, iconWidth: 45),
    SideNavItem(
      iconPath: SVGPath.eatOSLogo,
      text: 'Ver 4.9 FL 3.3.6',
      iconHeight: 40,
      iconWidth: 40,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.w,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.50),
            blurRadius: 5.w,
            spreadRadius: 0,
            offset: Offset(0.w, 1.h),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.50),
            blurRadius: 5.w,
            spreadRadius: 0,
            offset: Offset(0.w, -1.h),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + 8.h),
            SizedBox(height: 8.h),
            ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final item = items[index];
                if (index == 0) {
                  return InkResponse(
                    onTap: () => onItemTap?.call(index),
                    child: Container(
                      height: 50.h,
                      width: 60.w,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: item.iconHeight.h,
                            width: item.iconWidth.w,
                            child: SvgPicture.asset(
                              item.iconPath,
                              height: item.iconHeight.h,
                              width: item.iconWidth.w,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return InkResponse(
                  onTap: () => onItemTap?.call(index),
                  child: Container(
                    height: 109.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.50),
                          blurRadius: 0,
                          spreadRadius: 0,
                          offset: Offset(0.w, 1.h),
                        ),
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.50),
                          blurRadius: 0,
                          spreadRadius: 0,
                          offset: Offset(0.w, -1.h),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: item.iconHeight.h,
                          width: item.iconWidth.w,
                          child: SvgPicture.asset(
                            item.iconPath,
                            height: item.iconHeight.h,
                            width: item.iconWidth.w,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        if (item.text != null) ...[
                          Text(
                            item.text!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => SizedBox(height: 2.h),
              itemCount: items.length,
            ),
          ],
        ),
      ),
    );
  }
}
