import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pratical_task_app/core/constants/app_colors.dart';

class GuestListItemWidget extends StatelessWidget {
  final String? profileImage;
  final String name;
  final String email;
  final String mobileNo;

  const GuestListItemWidget({
    super.key,
    required this.name,
    required this.email,
    required this.mobileNo,
    this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 28.r,
            backgroundImage: profileImage != null
                ? AssetImage(profileImage!) as ImageProvider
                : null,
            child: profileImage == null
                ? Text(
                    name.split(' ').length > 1
                        ? name.split(' ')[0].substring(0, 1) +
                            name.split(' ')[1].substring(0, 1)
                        : name[0].substring(0, 1),
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  )
                : null,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
                Text(
                  email,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    height: 19.6.sp / 12.sp,
                    color: AppColors.primaryColor,
                  ),
                ),
                Text(
                  mobileNo,
                  style: TextStyle(
                    fontSize: 12.sp,
                    height: 19.6.sp / 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

