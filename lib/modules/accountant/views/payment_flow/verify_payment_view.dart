import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Added
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/app_text_styles.dart';
import '../../controllers/payment_flow_controller.dart';

class VerifyPaymentView extends GetView<PaymentFlowController> {
  const VerifyPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          'Verify Payment',
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
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            _buildPaymentDetailsCard(),
            SizedBox(height: 16.h),
            _buildPaymentSourceCard(),
            SizedBox(height: 100.h),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildPaymentDetailsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppText.paymentDetails.toUpperCase(),
            style: AppTextStyles.bodySmall.copyWith(
              letterSpacing: 1.0,
              color: AppColors.textSlate,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppText.requestedAmount,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSlate,
                ),
              ),
              Obx(
                () => Text(
                  '₹${controller.requestedAmount.value.toStringAsFixed(2)}',
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Divider(color: Colors.grey[200]),
          SizedBox(height: 20.h),
          Text(
            AppText.finalPayableAmount,
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                // const Icon(Icons.attach_money, size: 20, color: Colors.black), // Removed Dollar Icon
                Text(
                  '₹',
                  style: AppTextStyles.h2.copyWith(
                    fontSize: 20.sp,
                    color: Colors.black,
                  ),
                ), // Added Rupee Symbol
                SizedBox(width: 8.w),
                Obx(
                  () => Text(
                    controller.finalAmount.value.toStringAsFixed(2),
                    style: AppTextStyles.h2.copyWith(fontSize: 20.sp),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Text(
                AppText.adjustmentReason,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 4.w),
              Flexible(
                // Added Flexible to prevent overflow
                child: Text(
                  AppText.requiredIfAmountChanged,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSlate,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          TextField(
            controller: controller.adjustmentController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: AppText.reasonForModification,
              hintStyle: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSlate,
              ),
              filled: true,
              fillColor: AppColors.backgroundLight,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: AppColors.primaryBlue),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSourceCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppText.paymentSource.toUpperCase(),
            style: AppTextStyles.bodySmall.copyWith(
              letterSpacing: 1.0,
              color: AppColors.textSlate,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 20.h),
          // Only Bank Transfer/UPI Option
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryBlue, width: 2.w),
              borderRadius: BorderRadius.circular(16.r),
              color: const Color(0xFFF0FAFF),
            ),
            padding: EdgeInsets.all(4.w),
            child: ListTile(
              leading: Icon(
                Icons.account_balance,
                color: AppColors.primaryBlue,
                size: 24.sp,
              ),
              title: Text(
                AppText.bankTransferUpi,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                AppText.digitalPayment,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSlate,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 4.h,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              trailing: Icon(
                Icons.check_circle,
                color: AppColors.primaryBlue,
                size: 24.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10.r,
            offset: Offset(0, -4.h),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppText.totalPayment,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSlate,
                  ),
                ),
                Obx(
                  () => Text(
                    '₹${controller.finalAmount.value.toStringAsFixed(2)}',
                    style: AppTextStyles.h2.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 16.w), // Add spacing
            Expanded(
              child: SizedBox(
                height: 50.h,
                child: Obx(() {
                  final isEnabled =
                      controller.selectedPaymentSource.value.isNotEmpty;
                  return ElevatedButton(
                    onPressed:
                        isEnabled ? () => controller.onMakePayment() : null, // Disable interactions
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isEnabled
                              ? const Color(0xFF1aa3df)
                              : Colors.grey[300], // Bright vs Grey
                      foregroundColor:
                          isEnabled
                              ? Colors.white
                              : Colors.grey[600], // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      elevation: isEnabled ? 2 : 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            AppText.makePayment,
                            style: AppTextStyles.buttonText.copyWith(
                              fontSize: 16.sp,
                              color: isEnabled ? Colors.white : Colors.grey[600],
                            ),
                            overflow:
                                TextOverflow
                                    .ellipsis, // Prevent text overflow inside button
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(
                          Icons.arrow_forward,
                          size: 20.sp,
                          color: isEnabled ? Colors.white : Colors.grey[600],
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
