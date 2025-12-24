import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/app_text_styles.dart';

class PendingPaymentsTab extends StatelessWidget {
  const PendingPaymentsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Total Outstanding Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        AppText.totalOutstanding, 
                        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSlate, letterSpacing: 1.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.account_balance_wallet_outlined, color: AppColors.primaryBlue, size: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text('₹4,250.00', style: AppTextStyles.h1),
                ),
                const SizedBox(height: 8),
                Text(AppText.acrossPendingRequests, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSlate)),
              ],
            ),
          ),
          const SizedBox(height: 24),

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
          const SizedBox(height: 16),
          _buildRequestItem(
            context,
            id: '#REQ-8820',
            date: 'Oct 23',
            name: 'Michael Ross',
            department: 'Sales',
            category: 'Client Dinner',
            amount: '₹340.00',
          ),
           const SizedBox(height: 16),
          _buildRequestItem(
            context,
            id: '#REQ-8819',
            date: 'Oct 22',
            name: 'David Kim',
            department: 'IT Dept',
            category: 'Hardware Repair',
            amount: '₹850.00',
          ),
           const SizedBox(height: 16),
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
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(24),
           boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Expanded( // Make ID/Date flexible
                 child: Text(
                   '$id • $date', 
                   style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600, color: AppColors.textSlate),
                   overflow: TextOverflow.ellipsis,
                 ),
               ),
               const SizedBox(width: 8),
               Text(amount, style: AppTextStyles.bodyLarge.copyWith(color: AppColors.primaryBlue)),
            ],
          ),
          const SizedBox(height: 8),
          Text(name, style: AppTextStyles.bodyLarge),
          const SizedBox(height: 4),
          Text('$department • $category', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSlate)),
          const SizedBox(height: 20),
          Divider(color: Theme.of(context).dividerColor),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.successGreen.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(AppText.approved, style: AppTextStyles.bodySmall.copyWith(color: AppColors.successGreen, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(width: 8),
               Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.warningOrange.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(AppText.notPaid, style: AppTextStyles.bodySmall.copyWith(color: AppColors.warningOrange, fontWeight: FontWeight.w600)),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(AppText.view, style: AppTextStyles.buttonText.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: 14)),
                  const SizedBox(width: 4),
                  Icon(Icons.chevron_right_rounded, size: 20, color: Theme.of(context).iconTheme.color),
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
