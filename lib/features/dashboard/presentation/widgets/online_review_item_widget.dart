import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar_plus/flutter_rating_bar_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pratical_task_app/config/app_colors.dart';
import 'package:pratical_task_app/features/dashboard/domain/entities/review.dart';

class OnlineReviewItemWidget extends StatelessWidget {
  final ReviewModel reviewModel;

  const OnlineReviewItemWidget({super.key, required this.reviewModel});

  @override
  Widget build(BuildContext context) {
    final double d = 88.r; // avatar diameter (square)
    final double sw = 1.r; // border thickness
    return Stack(
      clipBehavior: Clip.none, // let the avatar overflow the card
      children: [
        Container(
          height: 150.h,
          width: 320.w,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColors.bgColor3, width: 1.w),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              SizedBox(
                width: 250.w,
                child: RatingBar.builder(
                  initialRating: reviewModel.ratings,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  wrapAlignment: WrapAlignment.center,
                  itemSize: 20.h,
                  itemBuilder: (context, _) =>
                      Icon(Icons.star, color: AppColors.ratingStarColor),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                reviewModel.review,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkGreyColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Positioned(
          top: -d / 2,
          left: 0,
          right: 0,
          child: SizedBox(
            width: d,
            height: d,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: d / 2,
                  child: SvgPicture.asset(
                    reviewModel.image,
                    height: d * 0.66,
                    width: d * 0.66,
                  ),
                ),
                // Paint the top-half border on top for crispness
                CustomPaint(
                  size: Size(d, d),
                  painter: _TopHalfCircleBorderPainter(
                    color: AppColors.bgColor3,
                    strokeWidth: sw,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TopHalfCircleBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  const _TopHalfCircleBorderPainter({
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );
    final paint = Paint()
      ..isAntiAlias = true
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt; // exact left/right stops

    // Top half arc from leftmost (π) to rightmost (0)
    canvas.drawArc(rect, math.pi, -math.pi, false, paint);
  }

  @override
  bool shouldRepaint(covariant _TopHalfCircleBorderPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
  }
}
