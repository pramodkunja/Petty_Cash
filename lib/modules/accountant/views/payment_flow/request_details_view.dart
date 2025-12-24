import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/app_text_styles.dart';
import '../../../../routes/app_routes.dart';
import '../../controllers/payment_flow_controller.dart';

class PaymentRequestDetailsView extends GetView<PaymentFlowController> {
  const PaymentRequestDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Request Details',
          style: AppTextStyles.h3.copyWith(color: AppColors.textDark), // Corrected style
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              'Requested Amount',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSlate),
            ),
            const SizedBox(height: 8),
            Text(
              '₹125.50',
              style: AppTextStyles.h1.copyWith(
                color: AppColors.textDark, 
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 24),
            _buildRequesterCard(),
            const SizedBox(height: 16),
            _buildBillAttachmentCard(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRequesterCard() {
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
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                child: Text('SJ', style: AppTextStyles.h3.copyWith(color: AppColors.primaryBlue, fontSize: 18)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sarah Jenkins',
                      style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Product Design • UX Designer',
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSlate),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(height: 1),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoItem(AppText.requestId.toUpperCase(), '#REQ-2023-849'),
              _buildInfoItem(AppText.date.toUpperCase(), 'Oct 23, 2023'),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            AppText.purpose.toUpperCase(),
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSlate, letterSpacing: 1.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Office Supplies for the new design sprint workshop held in Conference Room B.',
            style: AppTextStyles.bodyMedium.copyWith(height: 1.5, color: AppColors.textDark),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSlate, letterSpacing: 1.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildBillAttachmentCard() {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bill & Attachments',
                style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F4F0), // Light green-ish
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF98D8C3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.qr_code, size: 16, color: Color(0xFF2D8C6E)),
                    const SizedBox(width: 4),
                    Text(
                      'QR Verified',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: const Color(0xFF2D8C6E), 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.receipt_long, color: AppColors.textSlate, size: 30),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Staples Inc.',
                        style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Detected Total: ₹125.50',
                        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSlate),
                      ),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.ACCOUNTANT_PAYMENT_BILL_DETAILS);
                        },
                        child: Row(
                          children: [
                            Text(
                              'View Bill Details',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.primaryBlue, 
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            const Icon(Icons.chevron_right, size: 16, color: AppColors.primaryBlue),
                          ],
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
  }
}
