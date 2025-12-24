import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        title: Text('Verify Payment', style: AppTextStyles.h3.copyWith(color: AppColors.textDark)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildPaymentDetailsCard(),
            const SizedBox(height: 16),
            _buildPaymentSourceCard(),
            const SizedBox(height: 100),
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
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppText.paymentDetails.toUpperCase(),
            style: AppTextStyles.bodySmall.copyWith(letterSpacing: 1.0, color: AppColors.textSlate, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppText.requestedAmount,
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSlate),
              ),
                Obx(() => Text(
                '₹${controller.requestedAmount.value.toStringAsFixed(2)}',
                style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600, fontSize: 18),
              )),
            ],
          ),
          const SizedBox(height: 20),
          Divider(color: Colors.grey[200]),
          const SizedBox(height: 20),
          Text(
            AppText.finalPayableAmount,
            style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                // const Icon(Icons.attach_money, size: 20, color: Colors.black), // Removed Dollar Icon
                Text('₹', style: AppTextStyles.h2.copyWith(fontSize: 20, color: Colors.black)), // Added Rupee Symbol
                const SizedBox(width: 8),
                Obx(() => Text(
                  controller.finalAmount.value.toStringAsFixed(2),
                  style: AppTextStyles.h2.copyWith(fontSize: 20),
                )),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                AppText.adjustmentReason,
                style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 4),
              Flexible( // Added Flexible to prevent overflow
                child: Text(
                  AppText.requiredIfAmountChanged,
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSlate),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: controller.adjustmentController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: AppText.reasonForModification,
              hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSlate),
              filled: true,
              fillColor: AppColors.backgroundLight,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
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
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppText.paymentSource.toUpperCase(),
            style: AppTextStyles.bodySmall.copyWith(letterSpacing: 1.0, color: AppColors.textSlate, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          // Only Bank Transfer/UPI Option
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryBlue, width: 2),
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xFFF0FAFF),
            ),
            padding: const EdgeInsets.all(4),
            child: ListTile(
              leading: const Icon(Icons.account_balance, color: AppColors.primaryBlue),
              title: Text(AppText.bankTransferUpi, style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600)),
              subtitle: Text(AppText.digitalPayment, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSlate)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              trailing: const Icon(Icons.check_circle, color: AppColors.primaryBlue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceOption({
    required String title,
    required String subtitle,
    required String value,
    required String groupValue,
    required Function(String?) onChanged,
    bool showBalance = false,
    IconData? icon,
  }) {
    final isSelected = value == groupValue;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? AppColors.primaryBlue : Colors.grey[300]!,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(16),
        color: isSelected ? const Color(0xFFF0FAFF) : Colors.white,
      ),
      padding: const EdgeInsets.all(4),
      child: RadioListTile<String>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        activeColor: AppColors.primaryBlue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600)),
            if (showBalance)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F4F0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Text(
                      'Available: ₹420.50',
                      style: AppTextStyles.bodySmall.copyWith(color: const Color(0xFF2D8C6E), fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.account_balance_wallet, size: 14, color: Color(0xFF2D8C6E)),
                  ],
                ),
              ),
            if (icon != null)
               Icon(icon, color: Colors.grey[400]),
          ],
        ),
        subtitle: Text(subtitle, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSlate)),
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
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
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSlate),
                ),
                Obx(() => Text(
                  '₹${controller.finalAmount.value.toStringAsFixed(2)}',
                  style: AppTextStyles.h2.copyWith(fontWeight: FontWeight.bold),
                )),
              ],
            ),
            const SizedBox(width: 16), // Add spacing
            Expanded(
              child: SizedBox(
                height: 50,
                child: Obx(() {
                  final isEnabled = controller.selectedPaymentSource.value.isNotEmpty;
                  return ElevatedButton(
                    onPressed: isEnabled ? () => controller.onMakePayment() : null, // Disable interactions
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isEnabled ? const Color(0xFF1aa3df) : Colors.grey[300], // Bright vs Grey
                      foregroundColor: isEnabled ? Colors.white : Colors.grey[600], // Text color
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: isEnabled ? 2 : 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            AppText.makePayment,
                            style: AppTextStyles.buttonText.copyWith(
                              fontSize: 16,
                              color: isEnabled ? Colors.white : Colors.grey[600]
                            ),
                            overflow: TextOverflow.ellipsis, // Prevent text overflow inside button
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.arrow_forward, size: 20, color: isEnabled ? Colors.white : Colors.grey[600]),
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
