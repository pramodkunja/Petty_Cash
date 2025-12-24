import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        title: Text(AppText.confirmPayment, style: AppTextStyles.h3.copyWith(color: AppColors.textDark)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTotalPayableCard(),
            const SizedBox(height: 16),
            _buildTransactionDetailsCard(),
            const SizedBox(height: 24),
            Text(
              AppText.payViaInstalledApp,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSlate),
            ),
            const SizedBox(height: 16),
            _buildAppSelectionGrid(),
            const SizedBox(height: 32),
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
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Text(
            AppText.totalPayable,
            style: AppTextStyles.bodySmall.copyWith(letterSpacing: 1.0, color: AppColors.textSlate, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            '₹ 1,250.00',
            style: AppTextStyles.h1.copyWith(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F4F0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.verified, size: 16, color: Color(0xFF2D8C6E)),
                const SizedBox(width: 6),
                Text(
                  AppText.verifiedVendor,
                  style: AppTextStyles.bodySmall.copyWith(color: const Color(0xFF2D8C6E), fontWeight: FontWeight.bold),
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
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFFE0F7FA),
                  radius: 24,
                  child: Text(
                    'RS',
                    style: AppTextStyles.bodyLarge.copyWith(color: AppColors.primaryBlue, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppText.payingTo,
                        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSlate),
                      ),
                      Text(
                        'Rahul Sharma (Vendor)',
                        style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const Icon(Icons.qr_code, color: Colors.grey),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppText.upiId,
                        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSlate),
                      ),
                      Text(
                        'rahul.sharma@okhdfcbank',
                        style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.copy, size: 18, color: AppColors.primaryBlue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppSelectionGrid() {
    final apps = [
      {'name': AppText.gpay, 'icon': Icons.account_balance_wallet, 'color': Colors.blue},
      {'name': AppText.phonePe, 'icon': Icons.payments, 'color': Colors.purple},
      {'name': AppText.paytm, 'icon': Icons.account_balance, 'color': Colors.blueAccent},
      {'name': 'Custom', 'icon': Icons.keyboard, 'color': Colors.orange}, // Changed to Custom with Keyboard icon
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: apps.map((app) {
        return Obx(() {
          final isSelected = controller.selectedPaymentApp.value == app['name'];
          return GestureDetector(
            onTap: () => controller.selectPaymentApp(app['name'] as String),
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? AppColors.primaryBlue : Colors.grey[200]!,
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: [
                      if (isSelected)
                        BoxShadow(
                          color: AppColors.primaryBlue.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                    ],
                  ),
                  child: Icon(app['icon'] as IconData, color: app['color'] as Color, size: 30),
                ),
                const SizedBox(height: 8),
                Text(
                  app['name'] as String,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? AppColors.textDark : AppColors.textSlate // Corrected
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
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.backgroundLight,
      ),
      child: Column(
         mainAxisSize: MainAxisSize.min,
         children: [
            SizedBox(
              width: double.infinity,
              height: 56,
              child: Obx(() {
                final isEnabled = controller.selectedPaymentApp.value.isNotEmpty;
                return ElevatedButton(
                  onPressed: isEnabled ? () => controller.onPayViaUpi() : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isEnabled ? const Color(0xFF1aa3df) : Colors.grey[300],
                    foregroundColor: isEnabled ? Colors.white : Colors.grey[600],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: isEnabled ? 2 : 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(
                        AppText.payViaUpiApp,
                        style: AppTextStyles.buttonText.copyWith(
                          fontSize: 18,
                          color: isEnabled ? Colors.white : Colors.grey[600]
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.launch, color: isEnabled ? Colors.white : Colors.grey[600], size: 20),
                    ],
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock, size: 14, color: AppColors.textSlate),
                SizedBox(width: 6),
                Flexible(
                  child: Text(
                    AppText.securelyRedirects,
                    style: TextStyle(fontSize: 12, color: AppColors.textSlate),
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
