import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pratical_task_app/core/constants/app_colors.dart';
import 'package:pratical_task_app/core/constants/assets.dart';

class TopHeaderBar extends StatelessWidget implements PreferredSizeWidget {
  const TopHeaderBar({super.key, this.onMenuTap});

  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2965),
                blurRadius: 10.r,
                spreadRadius: 0.r,
                offset: Offset(0.w, 2.h),
              ),
            ],
          ),
          child: SizedBox(
            height: 64.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                children: [
                  InkWell(
                    onTap: onMenuTap,
                    child: Container(
                      height: 40.h,
                      width: 40.w,
                      padding: EdgeInsets.only(left: 5.w, top: 5.w),
                      child: SvgPicture.asset(
                        SVGPath.hamburgerIcon,
                        height: 20.h,
                        width: 30.w,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 40.w),
                  InkWell(
                    onTap: onMenuTap,
                    child: SizedBox(
                      height: 40.h,
                      width: 40.w,
                      child: SvgPicture.asset(
                        SVGPath.forwardBackwardArrowIcon,
                        height: 23.33.h,
                        width: 30.w,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 40.w),
                  SizedBox(
                    height: 40.h,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20.r,
                          backgroundImage: AssetImage(PNGPath.profileAvatar),
                        ),
                        SizedBox(width: 18.w),
                        Text(
                          'Johnson Francisco',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 21.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'Clocked in at 09 : 33 AM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '10:20 AM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 30.w),
                  SvgPicture.asset(
                    SVGPath.wifiIcon,
                    height: 18.h,
                    width: 18.w,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: 30.w),
                  Badge(
                    smallSize: 15.w,
                    backgroundColor: AppColors.badgeDotColor,
                    child: SvgPicture.asset(
                      SVGPath.notificationIcon,
                      height: 18.h,
                      width: 18.w,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -6.h,
          child: Container(
            width: 200.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2965),
                  blurRadius: 10.r,
                  spreadRadius: 0.r,
                  offset: Offset(0.w, 2.h),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 25.h,
                  width: 25.w,
                  child: SvgPicture.asset(
                    SVGPath.arrowDownIcon,
                    height: 25.h,
                    width: 25.w,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
