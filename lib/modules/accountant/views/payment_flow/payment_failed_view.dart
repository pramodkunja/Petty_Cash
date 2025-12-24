import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/app_text_styles.dart';

class PaymentFailedView extends StatelessWidget {
  const PaymentFailedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(AppText.paymentStatus, style: AppTextStyles.h3),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.errorRed.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.error_outline_rounded, size: 60, color: AppColors.errorRed),
            ),
            const SizedBox(height: 24),
            Text(AppText.paymentFailed, style: AppTextStyles.h1),
            const SizedBox(height: 12),
            Text(
              AppText.paymentFailedDesc,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSlate),
            ),
            const SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[200]!),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(Icons.receipt_long_rounded, color: AppColors.textSlate),
                        const SizedBox(width: 12),
                        Text(AppText.transactionDetails, style: AppTextStyles.bodySmall.copyWith(letterSpacing: 1.2, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: Colors.grey[200]),
                  _buildDetailRow(AppText.transactionId, '#TRX-9982', showCopy: true),
                  Divider(height: 1, color: Colors.grey[200]),
                  _buildDetailRow(AppText.date, 'Oct 24, 2023'),
                  Divider(height: 1, color: Colors.grey[200]),
                  _buildDetailRow(AppText.recipient, 'John Doe', isRecipient: true),
                  Divider(height: 1, color: Colors.grey[200]),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppText.totalAmount, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSlate)),
                        Text('\$450.00', style: AppTextStyles.h2.copyWith(color: AppColors.primaryBlue)), // TODO: Dynamic
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(), // Retry Logic could be here
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 0,
                ),
                child: Text(AppText.retryPayment, style: AppTextStyles.buttonText.copyWith(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.back(), // Go back Logic
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.backgroundLight,
                  side: BorderSide.none,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: Text(AppText.goBackToDetails, style: AppTextStyles.buttonText.copyWith(color: Colors.black)),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.headset_mic_outlined, size: 16, color: AppColors.textSlate),
                const SizedBox(width: 8),
                Text(AppText.needHelpContactSupport, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSlate)),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool showCopy = false, bool isRecipient = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSlate)),
          const SizedBox(width: 8),
          Flexible( // Use Flexible to allow shrinking
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end, // Align right
              children: [
                if (isRecipient) ...[
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      shape: BoxShape.circle,
                    ),
                    child: Text('JD', style: AppTextStyles.bodySmall.copyWith(fontSize: 10, color: AppColors.primaryBlue, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 8),
                ],
                Flexible( // Nested Flexible for text
                  child: Text(
                    value, 
                    style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (showCopy) ...[
                  const SizedBox(width: 8),
                  const Icon(Icons.copy_rounded, size: 16, color: AppColors.textSlate),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
