import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/app_text_styles.dart';
import '../../controllers/payment_flow_controller.dart';

class PaymentSuccessView extends GetView<PaymentFlowController> {
  const PaymentSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], 
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => controller.backToDashboard(),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(Icons.check, color: Colors.green, size: 40),
              ),
              const SizedBox(height: 24),
              Text(
                AppText.success,
                style: AppTextStyles.h1.copyWith(fontSize: 28),
              ),
              const SizedBox(height: 12),
              Text(
                AppText.fundsTransferred,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSlate, height: 1.5),
              ),
              const SizedBox(height: 32),
              
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text(
                      AppText.totalPaid,
                      style: AppTextStyles.bodySmall.copyWith(letterSpacing: 1.0, color: AppColors.textSlate, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '₹150.00',
                      style: AppTextStyles.h1.copyWith(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 24),
                    _buildReceiptRow(AppText.transactionId, '#TXN-883920', icon: Icons.copy),
                    const SizedBox(height: 16),
                    _buildReceiptRow(AppText.paymentDate, 'Oct 24, 2023\n10:45 AM'),
                    const SizedBox(height: 16),
                    _buildReceiptRow(AppText.paymentSource, 'Petty Cash Box A', isStatus: true, statusColor: Colors.green),
                    const SizedBox(height: 16),
                    _buildReceiptRow(AppText.recipient, 'Sarah Jenkins', useLocalAvatar: true),
                  ],
                ),
              ),
              const SizedBox(height: 48), // Replaces Spacer
              
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.ACCOUNTANT_PAYMENT_COMPLETED_DETAILS);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00C853),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(
                        AppText.viewRequestDetails,
                        style: AppTextStyles.buttonText.copyWith(fontSize: 16),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => controller.backToDashboard(),
                child: Text(
                  AppText.backToDashboard,
                  style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600, color: Colors.black),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value, {IconData? icon, bool isStatus = false, Color? statusColor, bool useLocalAvatar = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSlate),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (isStatus) ...[
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
                ),
                const SizedBox(width: 8),
              ],
               if (useLocalAvatar) ...[
                CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                  child: Text('SJ', style: AppTextStyles.bodySmall.copyWith(color: AppColors.primaryBlue, fontWeight: FontWeight.bold, fontSize: 10)),
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      value.split('\n')[0],
                      textAlign: TextAlign.right,
                      style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (value.contains('\n'))
                      Text(
                        value.split('\n')[1],
                        textAlign: TextAlign.right,
                        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSlate),
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              if (icon != null) ...[
                const SizedBox(width: 8),
                Icon(icon, size: 16, color: AppColors.textSlate),
              ]
            ],
          ),
        ),
      ],
    );
  }
}
