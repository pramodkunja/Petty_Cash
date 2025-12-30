import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Added
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/app_text_styles.dart';
import '../../controllers/payment_flow_controller.dart';

class ConfirmPaymentView extends GetView<PaymentFlowController> {
  const ConfirmPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          AppText.confirmPayment,
          style: AppTextStyles.h3.copyWith(color: AppColors.textDark),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.sp),
          onPressed: () => Get.back(),
        ),
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            _buildTotalPayableCard(),
            SizedBox(height: 16.h),
            _buildTransactionDetailsCard(),
            SizedBox(height: 24.h),
            Text(
              AppText.payViaInstalledApp,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSlate,
              ),
            ),
            SizedBox(height: 16.h),
            _buildAppSelectionGrid(),
            SizedBox(height: 32.h),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildTotalPayableCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 32.h),
      child: Column(
        children: [
          Text(
            AppText.totalPayable,
            style: AppTextStyles.bodySmall.copyWith(
              letterSpacing: 1.0,
              color: AppColors.textSlate,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            '₹ 1,250.00',
            style: AppTextStyles.h1.copyWith(
              fontSize: 40.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.successBg,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.verified,
                  size: 16.sp,
                  color: AppColors.successGreen,
                ),
                SizedBox(width: 6.w),
                Text(
                  AppText.verifiedVendor,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.successGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionDetailsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
        children: [
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFFE0F7FA),
                  radius: 24.r,
                  child: Text(
                    'RS',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppText.payingTo,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSlate,
                        ),
                      ),
                      Text(
                        'Rahul Sharma (Vendor)',
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1.h),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                const Icon(Icons.qr_code, color: Colors.grey),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppText.upiId,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSlate,
                        ),
                      ),
                      Text(
                        'rahul.sharma@okhdfcbank',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.copy, size: 18.sp, color: AppColors.primaryBlue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppSelectionGrid() {
    final apps = [
      {
        'name': AppText.gpay,
        'icon': Icons.account_balance_wallet,
        'color': AppColors.primaryBlue,
      },
      {
        'name': AppText.phonePe,
        'icon': Icons.payments,
        'color': AppColors.purple,
      },
      {
        'name': AppText.paytm,
        'icon': Icons.account_balance,
        'color': AppColors.indigo,
      },
      {
        'name': 'Custom',
        'icon': Icons.keyboard,
        'color': AppColors.warning,
      }, // Changed to Custom with Keyboard icon
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          apps.map((app) {
            return Obx(() {
              final isSelected =
                  controller.selectedPaymentApp.value == app['name'];
              return GestureDetector(
                onTap: () => controller.selectPaymentApp(app['name'] as String),
                child: Column(
                  children: [
                    Container(
                      width: 64.w,
                      height: 64.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color:
                              isSelected
                                  ? AppColors.primaryBlue
                                  : Colors.grey[200]!,
                          width: isSelected ? 2.w : 1.w,
                        ),
                        boxShadow: [
                          if (isSelected)
                            BoxShadow(
                              color: AppColors.primaryBlue.withOpacity(0.2),
                              blurRadius: 8.r,
                              offset: Offset(0, 4.h),
                            ),
                        ],
                      ),
                      child: Icon(
                        app['icon'] as IconData,
                        color: app['color'] as Color,
                        size: 30.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      app['name'] as String,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        color:
                            isSelected
                                ? AppColors.textDark
                                : AppColors.textSlate, // Corrected
                      ),
                    ),
                  ],
                ),
              );
            });
          }).toList(),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: const BoxDecoration(color: AppColors.backgroundLight),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: Obx(() {
              final isEnabled = controller.selectedPaymentApp.value.isNotEmpty;
              return ElevatedButton(
                onPressed: isEnabled ? () => controller.onPayViaUpi() : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isEnabled
                          ? AppColors.primaryBlue
                          : AppColors.textSlate.withOpacity(0.3),
                  foregroundColor:
                      isEnabled ? Colors.white : AppColors.textSlate,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  elevation: isEnabled ? 2 : 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppText.payViaUpiApp,
                      style: AppTextStyles.buttonText.copyWith(
                        fontSize: 18.sp,
                        color: isEnabled ? Colors.white : Colors.grey[600],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(
                      Icons.launch,
                      color: isEnabled ? Colors.white : Colors.grey[600],
                      size: 20.sp,
                    ),
                  ],
                ),
              );
            }),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock, size: 14.sp, color: AppColors.textSlate),
              SizedBox(width: 6.w),
              Flexible(
                child: Text(
                  AppText.securelyRedirects,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textSlate,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
