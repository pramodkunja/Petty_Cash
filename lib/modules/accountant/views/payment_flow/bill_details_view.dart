import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/app_text_styles.dart';
import '../../controllers/payment_flow_controller.dart'; // Correct relative import

class BillDetailsView extends GetView<PaymentFlowController> {
  const BillDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.isQrDetected.isFalse) {
        // Only start if not already detected
        controller.startQrSimulation();
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'INV-2023-001.pdf',
          style: AppTextStyles.h3.copyWith(color: Colors.white), // Correct
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: InteractiveViewer(
              child: Center(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.1),
                        blurRadius: 20,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.receipt_long, size: 80, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text(
                        'Invoice #INV-2023-001',
                        style: AppTextStyles.h3.copyWith(color: Colors.black),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Scanning for QR Code...',
                        style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          Obx(() {
            if (controller.isQrDetected.isTrue) {
              return _buildQrDetectedPopup();
            } else {
              return const SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }

  Widget _buildQrDetectedPopup() {
    return DraggableScrollableSheet(
      initialChildSize: 0.45,
      minChildSize: 0.2,
      maxChildSize: 0.6,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F7FA),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFB2EBF2)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 24),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppText.paymentDetailsFound,
                              style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              AppText.scannedFromQr,
                              style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSlate),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.check_circle, color: AppColors.primaryBlue, size: 24),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildDetailRow(AppText.payeeName, 'Office Supplies Co.', boldValue: true),
                const Divider(height: 24),
                _buildDetailRow(AppText.upiId, 'office.supplies@upi'),
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppText.amount,
                      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSlate),
                    ),
                    Text(
                      '₹145.00',
                      style: AppTextStyles.h1.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.onUseForPayment();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1aa3df), // Primary Blue
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppText.useForPayment,
                          style: AppTextStyles.buttonText.copyWith(fontSize: 18), // Correct
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      AppText.dismiss,
                      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSlate),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value, {bool boldValue = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primaryBlue),
        ),
        Text(
          value,
          style: boldValue 
              ? AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w700)
              : AppTextStyles.bodyMedium,
        ),
      ],
    );
  }
}
