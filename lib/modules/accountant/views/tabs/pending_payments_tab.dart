import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Added
import '../../../../routes/app_routes.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/app_text_styles.dart';

class PendingPaymentsTab extends StatelessWidget {
  const PendingPaymentsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          // Total Outstanding Card
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        AppText.totalOutstanding,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSlate,
                          letterSpacing: 1.0,
                          fontSize: 14.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.account_balance_wallet_outlined,
                        color: AppColors.primaryBlue,
                        size: 20.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text('₹4,250.00', style: AppTextStyles.h1),
                ),
                SizedBox(height: 8.h),
                Text(
                  AppText.acrossPendingRequests,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSlate,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // List of Pending Requests
          _buildRequestItem(
            context,
            id: '#REQ-8821',
            date: 'Oct 24',
            name: 'Sarah Jenkins',
            department: 'Operations',
            category: 'Office Supplies',
            amount: '₹125.50',
          ),
          SizedBox(height: 16.h),
          _buildRequestItem(
            context,
            id: '#REQ-8820',
            date: 'Oct 23',
            name: 'Michael Ross',
            department: 'Sales',
            category: 'Client Dinner',
            amount: '₹340.00',
          ),
          SizedBox(height: 16.h),
          _buildRequestItem(
            context,
            id: '#REQ-8819',
            date: 'Oct 22',
            name: 'David Kim',
            department: 'IT Dept',
            category: 'Hardware Repair',
            amount: '₹850.00',
          ),
          SizedBox(height: 16.h),
          _buildRequestItem(
            context,
            id: '#REQ-8815',
            date: 'Oct 21',
            name: 'Emily Chen',
            department: 'Marketing',
            category: 'Ad Spend',
            amount: '₹2,934.50',
          ),
        ],
      ),
    );
  }

  Widget _buildRequestItem(
    BuildContext context, {
    required String id,
    required String date,
    required String name,
    required String department,
    required String category,
    required String amount,
  }) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.ACCOUNTANT_PAYMENT_REQUEST_DETAILS);
      },
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  // Make ID/Date flexible
                  child: Text(
                    '$id • $date',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSlate,
                      fontSize: 12.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
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
            SizedBox(height: 8.h),
            Text(name, style: AppTextStyles.bodyLarge),
            SizedBox(height: 4.h),
            Text(
              '$department • $category',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSlate,
              ),
            ),
            SizedBox(height: 20.h),
            Divider(color: Theme.of(context).dividerColor),
            SizedBox(height: 16.h),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.successGreen.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    AppText.approved,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.successGreen,
                      fontWeight: FontWeight.w600,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.warningOrange.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    AppText.notPaid,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.warningOrange,
                      fontWeight: FontWeight.w600,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      AppText.view,
                      style: AppTextStyles.buttonText.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 20.sp,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
