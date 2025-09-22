import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pratical_task_app/core/constants/app_colors.dart';
import 'package:pratical_task_app/core/constants/assets.dart';
import 'package:pratical_task_app/features/dashboard/domain/entities/guest_user.dart';
import 'package:pratical_task_app/features/dashboard/domain/entities/review.dart';
import 'package:pratical_task_app/features/dashboard/presentation/widgets/guest_list_item.dart';
import 'package:pratical_task_app/features/dashboard/presentation/widgets/notes_input_item.dart';
import 'package:pratical_task_app/features/dashboard/presentation/widgets/online_review_item_widget.dart';
import 'package:pratical_task_app/features/dashboard/presentation/widgets/other_input_field.dart';
import 'package:pratical_task_app/features/dashboard/presentation/widgets/side_nav.dart';
import 'package:pratical_task_app/features/dashboard/presentation/widgets/title_value_item.dart';
import 'package:pratical_task_app/features/dashboard/presentation/widgets/top_header.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showGuestList = true; // responsive default set on first build
  bool _initialized = false;

  final List<GuestUserModel> _guestUserList = [
    GuestUserModel(
      name: 'Lia Thomas',
      email: 'lia.thomas516@reddit.com',
      mobileNo: '+1 212-450-7890',
      profileImage: PNGPath.profileAvatar,
    ),
    GuestUserModel(
      name: 'Bergnaum',
      email: 'cleorahills@gmail.com',
      mobileNo: '+1 212-450-7890',
      profileImage: PNGPath.bergnaum,
    ),
    GuestUserModel(
      name: 'Wunderlich',
      email: 'wunder@gmail.com',
      mobileNo: '+1 212-450-7890',
      profileImage: PNGPath.wunderlich,
    ),
    GuestUserModel(
      name: 'Arjun Gerhold',
      email: 'alaskanm@dog.com',
      mobileNo: '+1 212-450-7890',
    ),
    GuestUserModel(
      name: 'Simeon Wilderman',
      email: 'simeon@user.com',
      mobileNo: '+1 212-450-7890',
    ),
    GuestUserModel(
      name: 'Eden Kautzer',
      email: 'edenka@user.com',
      mobileNo: '+1 212-450-7890',
      profileImage: PNGPath.edenKautzer,
    ),
    GuestUserModel(
      name: 'Gino Yost',
      email: 'gyostt@Test.com',
      mobileNo: '+1 212-450-7890',
      profileImage: PNGPath.ginoYost,
    ),
    GuestUserModel(
      name: 'Ayden Veum',
      email: 'aydeveu@synd.com',
      mobileNo: '+1 212-450-7890',
      profileImage: PNGPath.aydenVeum,
    ),
    GuestUserModel(
      name: 'Johnson Francisco',
      email: 'john@synd.com',
      mobileNo: '+1 212-450-7890',
    ),
  ];

  final List<ReviewModel> _onlineReviewList = [
    ReviewModel(
      image: SVGPath.googleIcon,
      review:
          'The food was absolutely delicious and served with great presentation. The staff were friendly and attentive.',
      ratings: 4.0,
    ),
    ReviewModel(
      image: SVGPath.googleIcon,
      review:
          'The food was absolutely delicious and served with great presentation. The staff were friendly and attentive.',
      ratings: 4.0,
    ),
    ReviewModel(
      image: SVGPath.googleIcon,
      review:
          'The food was absolutely delicious and served with great presentation. The staff were friendly and attentive.',
      ratings: 4.0,
    ),
    ReviewModel(
      image: SVGPath.googleIcon,
      review:
          'The food was absolutely delicious and served with great presentation. The staff were friendly and attentive.',
      ratings: 4.0,
    ),
    ReviewModel(
      image: SVGPath.googleIcon,
      review:
          'The food was absolutely delicious and served with great presentation. The staff were friendly and attentive.',
      ratings: 4.0,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  void _setResponsiveDefaults(BoxConstraints c) {
    if (_initialized) return;
    final isCompact = c.maxWidth < 1100; // tablet portrait or narrow windows
    _showGuestList = !isCompact;
    _initialized = true;
  }

  // Computes a responsive target width for the left guest list panel
  double _leftPanelWidth(BoxConstraints c) {
    // Clamp width between ~260 and ~360 logical px, or 22% of available
    final target = c.maxWidth * 0.22;
    return math.max(260.w, math.min(360.w, target));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _setResponsiveDefaults(constraints);
        final leftWidth = _leftPanelWidth(constraints);
        return Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: TopHeaderBar(
            onMenuTap: () {
              setState(() => _showGuestList = true);
            },
          ),
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SideNavigationMenu(),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Animated left guest list panel
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 240),
                      curve: Curves.easeInOut,
                      width: _showGuestList ? leftWidth : 0,
                      child: IgnorePointer(
                        ignoring: !_showGuestList,
                        child: Opacity(
                          opacity: _showGuestList ? 1 : 0,
                          child: _leftGuestListPanel(),
                        ),
                      ),
                    ),
                    // Animated divider between left and right
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      width: _showGuestList ? 2.254.w : 0,
                      child: _showGuestList
                          ? VerticalDivider(
                              width: 2.254.w,
                              color: AppColors.dividerColor3,
                            )
                          : const SizedBox.shrink(),
                    ),
                    // Right content panel with optional tap-to-hide overlay when guest list visible
                    Expanded(
                      child: Stack(
                        children: [
                          _rightContentPanel(),
                          if (_showGuestList)
                            Positioned.fill(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () =>
                                      setState(() => _showGuestList = false),
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _leftGuestListPanel() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Row(
            children: [
              InkWell(
                child: const Icon(
                  Icons.chevron_left,
                  color: AppColors.darkGreyColor,
                ),
                onTap: () => setState(() => _showGuestList = false),
              ),
              SizedBox(width: 2.w),
              Text(
                'Settings',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkGreyColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          SizedBox(
            height: 28.h,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.iconColor,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 20.31.h,
                    width: 20.31.w,
                    child: SvgPicture.asset(
                      SVGPath.searchIcon,
                      height: 20.31.h,
                      width: 20.31.w,
                      colorFilter: const ColorFilter.mode(
                        AppColors.iconColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 24.w,
                  maxHeight: 24.h,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 19.h,
                    width: 14.w,
                    child: SvgPicture.asset(
                      SVGPath.keyboardVoiceIcon,
                      height: 19.h,
                      width: 14.w,
                      colorFilter: const ColorFilter.mode(
                        AppColors.iconColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                suffixIconConstraints: BoxConstraints(
                  minWidth: 24.w,
                  maxHeight: 24.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.bgColor2,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      height: 30.h,
                      width: 30.w,
                      child: SvgPicture.asset(SVGPath.addIcon),
                    ),
                    SizedBox(width: 15.w),
                    SizedBox(
                      height: 30.h,
                      width: 30.w,
                      child: SvgPicture.asset(SVGPath.archiveIcon),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32.h,
                width: 32.w,
                child: Image.asset(PNGPath.sortIcon),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(bottom: 16.h),
              itemBuilder: (context, index) {
                return GuestListItemWidget(
                  name: _guestUserList[index].name,
                  email: _guestUserList[index].email,
                  mobileNo: _guestUserList[index].mobileNo,
                  profileImage: _guestUserList[index].profileImage,
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: AppColors.dividerColor4,
                  thickness: 1.h,
                  height: 1.h,
                );
              },
              itemCount: _guestUserList.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _rightContentPanel() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!_showGuestList)
              Padding(
                padding: EdgeInsets.only(top: 11.h),
                child: Row(
                  children: [
                    InkWell(
                      child: const Icon(
                        Icons.chevron_left,
                        color: AppColors.darkGreyColor,
                      ),
                      onTap: () => setState(() => _showGuestList = true),
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Guests Book',
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: AppColors.darkGreyColor,
                        letterSpacing: -0.4.sp,
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 20.h),
            _guestBookWidget(),
            SizedBox(height: 20.h),
            _tabListWidget(),
            SizedBox(height: 20.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(flex: 2, child: _guestProfileViewWidget()),
                    VerticalDivider(
                      radius: BorderRadius.circular(40),
                      color: AppColors.dividerColor.withValues(alpha: 0.30),
                      thickness: 2.w,
                      width: 2.w,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(flex: 7, child: _profileStatsWidget()),
                    SizedBox(width: 12.w),
                    if (!_showGuestList)
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Expanded(flex: 3, child: _noOrderedItemsWidget()),
                            SizedBox(height: 12.h),
                            Expanded(flex: 1, child: _noVehicleWidget()),
                          ],
                        ),
                      ),
                    if (!_showGuestList) SizedBox(width: 12.w),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            _allergiesWidget(),
            SizedBox(height: 20.h),
            _upcomingVisitsWidget(),
            SizedBox(height: 20.h),
            _notesWidget(),
            SizedBox(height: 20.h),
            _recentOrdersWidget(),
            SizedBox(height: 20.h),
            _onlineReviewsWidget(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _guestBookWidget() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 100.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            SVGPath.guestBookIcon,
            height: 54.h,
            width: 54.w,
            colorFilter: const ColorFilter.mode(
              AppColors.darkGreyColor,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Guest Book',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'The guest book feature remembers your guests\' dietary needs, allergies, and favorite dishes. It organizes dining preferences for a customized and memorable experience, ensuring each visit is tailored to their individual needs.',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.darkGreyColor2,
              height: 28.sp / 20.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _tabListWidget() {
    return Container(
      height: 36.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      margin: EdgeInsets.symmetric(horizontal: _showGuestList ? 40.w : 160.w),
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
      child: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(text: 'Profile'),
          Tab(text: 'Reservation'),
          Tab(text: 'Payment'),
          Tab(text: 'Feedback'),
          Tab(text: 'Order History'),
        ],
        labelStyle: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          color: AppColors.darkGreyColor,
        ),
      ),
    );
  }

  Widget _guestProfileViewWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 8.r,
                  offset: Offset(0, 2.h),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 36.r,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(36.r),
                child: Image.asset(
                  PNGPath.profileAvatar,
                  height: 72.h,
                  width: 72.w,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Lia Thomas',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'lia.thomas516@reddit.com',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.h),
          Text(
            '+1 212-450-7890',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36.r),
              ),
              padding: EdgeInsets.zero,
              backgroundColor: AppColors.primaryColor,
              fixedSize: Size(110.w, 24.h),
            ),
            child: Text(
              'Add Tags',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileStatsWidget() {
    return Column(
      children: [
        Container(
          height: 80.h,
          decoration: BoxDecoration(
            color: AppColors.bgColor,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TitleValueItemWidget(
                title: 'Last Visit',
                value: '-- -- --',
                gap: 16.h,
              ),
              VerticalDivider(
                color: AppColors.dividerColor2,
                thickness: 1.w,
                width: 1.w,
              ),
              TitleValueItemWidget(
                title: 'Average Spend',
                value: '\$0.00',
                gap: 16.h,
              ),
              VerticalDivider(
                color: AppColors.dividerColor2,
                thickness: 1.w,
                width: 1.w,
              ),
              TitleValueItemWidget(
                title: 'Lifetime Spend',
                value: '\$0.00',
                gap: 16.h,
              ),
              VerticalDivider(
                color: AppColors.dividerColor2,
                thickness: 1.w,
                width: 1.w,
              ),
              TitleValueItemWidget(
                title: 'Total Orders',
                value: '0',
                gap: 16.h,
              ),
              VerticalDivider(
                color: AppColors.dividerColor2,
                thickness: 1.w,
                width: 1.w,
              ),
              TitleValueItemWidget(
                title: 'Average Tip',
                value: '\$0.00',
                gap: 16.h,
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        Expanded(
          child: Row(
            children: [
              Expanded(flex: 4, child: _otherInputFieldWidgets()),
              SizedBox(width: 16.w),
              Expanded(flex: 3, child: _loyaltyWidget()),
              SizedBox(width: 12.w),
              Expanded(flex: 3, child: _visitsWidget()),
            ],
          ),
        ),
        if (_showGuestList)
          Container(
            height: 50.h,
            padding: EdgeInsets.only(top: 12.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _noOrderedItemsWidget()),
                SizedBox(width: 12.w),
                Expanded(child: _noVehicleWidget()),
              ],
            ),
          ),
      ],
    );
  }

  Widget _otherInputFieldWidgets() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Column(
        children: [
          const OtherInputFieldWidget(title: 'Loyalty No'),
          SizedBox(height: 5.h),
          Divider(color: AppColors.dividerColor2, thickness: 1.h, height: 1.h),
          SizedBox(height: 5.h),
          const OtherInputFieldWidget(title: 'Customer Since'),
          SizedBox(height: 5.h),
          Divider(color: AppColors.dividerColor2, thickness: 1.h, height: 1.h),
          SizedBox(height: 5.h),
          const OtherInputFieldWidget(
            title: 'Birthday',
            iconPath: SVGPath.birthdayIcon,
            iconHeight: 13.13,
            iconWidth: 12.5,
          ),
          SizedBox(height: 5.h),
          Divider(color: AppColors.dividerColor2, thickness: 1.h, height: 1.h),
          SizedBox(height: 5.h),
          const OtherInputFieldWidget(
            title: 'Anniversary',
            iconPath: SVGPath.anniversaryIcon,
            iconHeight: 12.84,
            iconWidth: 10.24,
          ),
        ],
      ),
    );
  }

  Widget _loyaltyWidget() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'LOYALTY',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 12.h),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: TitleValueItemWidget(
                    title: 'Earned',
                    value: '0',
                    titleFontSize: 14.sp,
                    gap: 8.h,
                  ),
                ),
                Expanded(
                  child: VerticalDivider(
                    color: AppColors.dividerColor2,
                    thickness: 1.w,
                    width: 1.w,
                  ),
                ),
                SizedBox(width: 5.w),
                Expanded(
                  flex: 4,
                  child: TitleValueItemWidget(
                    title: 'Redeemed',
                    value: '0',
                    titleFontSize: 14.sp,
                    gap: 8.h,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: TitleValueItemWidget(
                    title: 'Available',
                    value: '0',
                    titleFontSize: 14.sp,
                    gap: 8.h,
                  ),
                ),
                Expanded(
                  child: VerticalDivider(
                    color: AppColors.dividerColor2,
                    thickness: 1.w,
                    width: 1.w,
                  ),
                ),
                SizedBox(width: 5.w),
                Expanded(
                  flex: 4,
                  child: TitleValueItemWidget(
                    title: 'Amount',
                    value: '\$0.00',
                    titleFontSize: 14.sp,
                    gap: 8.h,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _visitsWidget() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'VISITS',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 12.h),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: TitleValueItemWidget(
                    title: 'Total Visits',
                    value: '0',
                    titleFontSize: 14.sp,
                    gap: 8.h,
                  ),
                ),
                Expanded(
                  child: VerticalDivider(
                    color: AppColors.dividerColor2,
                    thickness: 1.w,
                    width: 1.w,
                  ),
                ),
                SizedBox(width: 5.w),
                Expanded(
                  flex: 4,
                  child: TitleValueItemWidget(
                    title: 'Upcoming',
                    value: '0',
                    titleFontSize: 14.sp,
                    gap: 8.h,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: TitleValueItemWidget(
                    title: 'Canceled',
                    value: '0',
                    titleFontSize: 14.sp,
                    gap: 8.h,
                  ),
                ),
                Expanded(
                  child: VerticalDivider(
                    color: AppColors.dividerColor2,
                    thickness: 1.w,
                    width: 1.w,
                  ),
                ),
                SizedBox(width: 5.w),
                Expanded(
                  flex: 4,
                  child: TitleValueItemWidget(
                    title: 'No Shows',
                    value: '0',
                    titleFontSize: 14.sp,
                    gap: 8.h,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _noOrderedItemsWidget() {
    return !_showGuestList
        ? Container(
            decoration: BoxDecoration(
              color: AppColors.bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 26.67.h,
                  width: 26.67.w,
                  child: SvgPicture.asset(
                    SVGPath.orderItemIcon,
                    height: 26.67.h,
                    width: 26.67.w,
                    colorFilter: const ColorFilter.mode(
                      AppColors.darkGreyColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                Text(
                  'No Ordered Items',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          )
        : Container(
            decoration: BoxDecoration(
              color: AppColors.bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 19.h,
                  width: 19.w,
                  child: SvgPicture.asset(
                    SVGPath.orderItemIcon,
                    height: 19.h,
                    width: 19.w,
                    colorFilter: const ColorFilter.mode(
                      AppColors.darkGreyColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  'No Ordered Items',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          );
  }

  Widget _noVehicleWidget() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 17.h,
            width: 20.w,
            child: SvgPicture.asset(
              SVGPath.vehicleIcon,
              height: 17.h,
              width: 20.w,
              colorFilter: const ColorFilter.mode(
                AppColors.darkGreyColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          !_showGuestList
              ? Expanded(
                  child: Text(
                    'No Recent Vehicle To Show',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                )
              : Text(
                  'No Recent Vehicle To Show',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
        ],
      ),
    );
  }

  Widget _allergiesWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            'ALLERGIES',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
          ),
        ),
        SizedBox(height: 5.h),
        Container(
          height: 70.h,

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 27.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 32.h,
                    width: 32.w,
                    child: SvgPicture.asset(
                      SVGPath.menuIcon,
                      height: 32.h,
                      width: 32.w,
                      colorFilter: ColorFilter.mode(
                        AppColors.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  SizedBox(width: 27.w),
                  VerticalDivider(
                    color: AppColors.dividerColor.withValues(alpha: 0.30),
                    thickness: 2.w,
                    width: 2.w,
                  ),
                  SizedBox(width: 27.w),
                  Text(
                    'No Allergies',
                    style: TextStyle(
                      fontSize: 18.sp,
                      height: 20.sp / 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(38.r),
                  ),
                  padding: EdgeInsets.zero,
                  backgroundColor: AppColors.primaryColor,
                  fixedSize: Size(62.w, 33.h),
                ),
                child: Text(
                  'Add',
                  style: TextStyle(
                    fontSize: 18.sp,
                    height: 20.sp / 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _upcomingVisitsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            'UPCOMING VISITS',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
          ),
        ),
        SizedBox(height: 5.h),
        Container(
          height: 70.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 27.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 32.h,
                    width: 32.w,
                    child: SvgPicture.asset(
                      SVGPath.upcomingVisitsIcon,
                      height: 32.h,
                      width: 32.w,
                      colorFilter: ColorFilter.mode(
                        AppColors.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  SizedBox(width: 27.w),
                  VerticalDivider(
                    color: AppColors.dividerColor.withValues(alpha: 0.30),
                    thickness: 2.w,
                    width: 2.w,
                  ),
                  SizedBox(width: 27.w),
                  Text(
                    'No Upcoming Visits',
                    style: TextStyle(
                      fontSize: 18.sp,
                      height: 20.sp / 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(38.r),
                  ),
                  padding: EdgeInsets.zero,
                  backgroundColor: AppColors.primaryColor,
                  fixedSize: Size(145.w, 33.h),
                ),
                child: Text(
                  'Book A Visit',
                  style: TextStyle(
                    fontSize: 18.sp,
                    height: 20.sp / 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _notesWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            'NOTES',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
          ),
        ),
        SizedBox(height: 5.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 15.h),
              NotesInputItemWidget(
                title: 'General',
                iconPath: SVGPath.generalIcon,
                iconHeight: 16,
                iconWidth: 14,
                onChanged: (value) {},
              ),
              Divider(
                thickness: 1.h,
                height: 1.h,
                color: AppColors.borderColor,
              ),
              SizedBox(height: 15.h),
              NotesInputItemWidget(
                title: 'Special Relation',
                iconPath: SVGPath.starIcon,
                iconHeight: 16.28,
                iconWidth: 17,
                onChanged: (value) {},
              ),
              Divider(
                thickness: 1.h,
                height: 1.h,
                color: AppColors.borderColor,
              ),
              SizedBox(height: 15.h),
              NotesInputItemWidget(
                title: 'Seating Preferences',
                iconPath: SVGPath.tableSeatingIcon,
                iconHeight: 18,
                iconWidth: 18,
                onChanged: (value) {},
              ),
              Divider(
                thickness: 1.h,
                height: 1.h,
                color: AppColors.borderColor,
              ),
              SizedBox(height: 15.h),
              NotesInputItemWidget(
                title: 'Special Note*',
                iconPath: SVGPath.starNotesIcon,
                iconHeight: 18,
                iconWidth: 18,
                onChanged: (value) {},
              ),
              Divider(
                thickness: 1.h,
                height: 1.h,
                color: AppColors.borderColor,
              ),
              SizedBox(height: 15.h),
              NotesInputItemWidget(
                title: 'Allergies',
                iconPath: SVGPath.allergiesIcon,
                iconHeight: 18,
                iconWidth: 18,
                onChanged: (value) {},
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ],
    );
  }

  Widget _recentOrdersWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            'RECENT ORDERS',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
          ),
        ),
        SizedBox(height: 5.h),
        Container(
          height: 70.h,

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 27.w),
          child: Row(
            children: [
              SizedBox(
                height: 32.h,
                width: 32.w,
                child: SvgPicture.asset(
                  SVGPath.menuOrderIcon,
                  height: 32.h,
                  width: 32.w,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(width: 27.w),
              VerticalDivider(
                color: AppColors.dividerColor.withValues(alpha: 0.30),
                thickness: 2.w,
                width: 2.w,
              ),
              SizedBox(width: 27.w),
              Text(
                'No Recent Orders to Show',
                style: TextStyle(
                  fontSize: 18.sp,
                  height: 20.sp / 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _onlineReviewsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            'ONLINE REVIEWS',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
          ),
        ),
        SizedBox(height: 5.h),
        _onlineReviewList.isEmpty
            ? Container(
                height: 70.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 27.w),
                child: Row(
                  children: [
                    SizedBox(
                      height: 32.h,
                      width: 32.w,
                      child: SvgPicture.asset(
                        SVGPath.reviewIcon,
                        height: 32.h,
                        width: 32.w,
                        colorFilter: const ColorFilter.mode(
                          AppColors.primaryColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    SizedBox(width: 27.w),
                    VerticalDivider(
                      color: AppColors.dividerColor.withValues(alpha: 0.30),
                      thickness: 2.w,
                      width: 2.w,
                    ),
                    SizedBox(width: 27.w),
                    Text(
                      'No Online Reviews to Show',
                      style: TextStyle(
                        fontSize: 18.sp,
                        height: 20.sp / 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                height: 210.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColors.bgColor3, width: 1.w),
                ),
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 40.w),
                child: ListView.separated(
                  itemCount: _onlineReviewList.length,
                  separatorBuilder: (context, index) => SizedBox(width: 30.w),
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(top: 24.h, bottom: 8.h),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final review = _onlineReviewList[index];
                    return OnlineReviewItemWidget(reviewModel: review);
                  },
                ),
              ),
      ],
    );
  }
}
