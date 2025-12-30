import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Added
import '../../../../routes/app_routes.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/app_text_styles.dart';
import '../../../../utils/widgets/custom_search_bar.dart';

class CompletedPaymentsTab extends StatelessWidget {
  const CompletedPaymentsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          // Search Bar
          const CustomSearchBar(
            hintText: AppText.searchByIdOrName,
          ),
          SizedBox(height: 24.h),

          // Total Disbursed Card
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppText.totalDisbursed,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSlate,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Expanded(
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.scaleDown,
                              child:
                                  Text('₹14,250.00', style: AppTextStyles.h1),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            '+2.4%',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.successGreen,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(
                            Icons.trending_up,
                            color: AppColors.successGreen,
                            size: 16.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9), // Slate 100
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Icon(
                    Icons.attach_money_rounded,
                    size: 32.sp,
                    color: Colors.white,
                  ), // The image has a specific styling, using Icon for now
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          // Filters Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(context, 'Date Range'),
                SizedBox(width: 8.w),
                _buildFilterChip(context, 'Department'),
                SizedBox(width: 8.w),
                _buildFilterChip(context, 'Category'),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppText.thisMonth,
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
                color: AppColors.textLight,
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // List Items
          _buildCompletedItem(
            context,
            id: '#REQ-8821',
            date: 'Oct 26, 2023',
            name: 'Sarah Jenkins',
            details: 'Marketing • Office Supplies',
            amount: '₹45.50',
          ),
          SizedBox(height: 16.h),
          _buildCompletedItem(
            context,
            id: '#REQ-8820',
            date: 'Oct 25, 2023',
            name: 'Michael Ross',
            details: 'Sales • Client Entertainment',
            amount: '₹120.00',
          ),
          SizedBox(height: 16.h),
          _buildCompletedItem(
            context,
            id: '#REQ-8819',
            date: 'Oct 24, 2023',
            name: 'David Chen',
            details: 'IT Dept • Hardware',
            amount: '₹850.00',
          ),
          SizedBox(height: 16.h),
          _buildCompletedItem(
            context,
            id: '#REQ-8815',
            date: 'Oct 21, 2023',
            name: 'Emily Chen',
            details: 'Marketing • Ad Spend',
            amount: '₹2,934.50',
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSlate),
          ),
          SizedBox(width: 4.w),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 16.sp,
            color: AppColors.textSlate,
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedItem(
    BuildContext context, {
    required String id,
    required String date,
    required String name,
    required String details,
    required String amount,
  }) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.ACCOUNTANT_PAYMENT_COMPLETED_DETAILS);
      },
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  // Allow ID to shrink/truncate
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      id,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSlate,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F2FE),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    AppText.completedSC,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.w700,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppTextStyles.bodyLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        details,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSlate,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  amount,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.primaryBlue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Divider(color: Theme.of(context).dividerColor),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        size: 14.sp,
                        color: AppColors.textLight,
                      ),
                      SizedBox(width: 6.w),
                      Flexible(
                        child: Text(
                          date,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textLight,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 20.sp,
                  color: AppColors.textDark,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
