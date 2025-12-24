import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/app_text_styles.dart';
import '../../../../utils/widgets/custom_search_bar.dart';

class CompletedPaymentsTab extends StatelessWidget {
  const CompletedPaymentsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Search Bar
           const CustomSearchBar(
             hintText: AppText.searchByIdOrName,
           ),
          const SizedBox(height: 24),

          // Total Disbursed Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(24),
            ),
             child: Row(
               children: [
                 Expanded(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(AppText.totalDisbursed, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSlate)),
                       const SizedBox(height: 8),
                       Row(
                         children: [
                           Expanded(
                             child: FittedBox(
                               alignment: Alignment.centerLeft,
                               fit: BoxFit.scaleDown,
                               child: Text('₹14,250.00', style: AppTextStyles.h1),
                             ),
                           ),
                           const SizedBox(width: 8),
                            Text(
                            '+2.4%',
                            style: AppTextStyles.bodySmall.copyWith(color: AppColors.successGreen, fontWeight: FontWeight.w600),
                           ),
                             const Icon(Icons.trending_up, color: AppColors.successGreen, size: 16),
                         ],
                       ),
                     ],
                   ),
                 ),
                 Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9), // Slate 100
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(Icons.attach_money_rounded, size: 32, color: Colors.white), // The image has a specific styling, using Icon for now
                  ),
               ],
             ),
          ),
          const SizedBox(height: 20),

          // Filters Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(context, 'Date Range'),
                const SizedBox(width: 8),
                _buildFilterChip(context, 'Department'),
                const SizedBox(width: 8),
                _buildFilterChip(context, 'Category'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          Align(
            alignment: Alignment.centerLeft,
            child: Text(AppText.thisMonth, style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w700, letterSpacing: 1.0, color: AppColors.textLight)),
          ),
          const SizedBox(height: 16),

          // List Items
          _buildCompletedItem(
            context,
             id: '#REQ-8821',
            date: 'Oct 26, 2023',
            name: 'Sarah Jenkins',
            details: 'Marketing • Office Supplies',
            amount: '₹45.50',
          ),
           const SizedBox(height: 16),
          _buildCompletedItem(
            context,
             id: '#REQ-8820',
            date: 'Oct 25, 2023',
            name: 'Michael Ross',
            details: 'Sales • Client Entertainment',
            amount: '₹120.00',
          ),
           const SizedBox(height: 16),
          _buildCompletedItem(
             context,
             id: '#REQ-8819',
            date: 'Oct 24, 2023',
            name: 'David Chen',
            details: 'IT Dept • Hardware',
            amount: '₹850.00',
          ),
           const SizedBox(height: 16),
          _buildCompletedItem(
             context,
             id: '#REQ-8815',
            date: 'Oct 21, 2023',
            name: 'Emily Chen',
            details: 'Marketing • Ad Spend',
            amount: '₹2,934.50',
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSlate)),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: AppColors.textSlate),
        ],
      ),
    );
  }

  Widget _buildCompletedItem(
     BuildContext context, {
    required String id,
    required String date,
    required String name,
    required String details,
    required String amount,
  }) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.ACCOUNTANT_PAYMENT_COMPLETED_DETAILS);
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Flexible( // Allow ID to shrink/truncate
                   child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      id, 
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSlate, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                 ),
                 const SizedBox(width: 8),
                 Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F2FE),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(AppText.completedSC, style: AppTextStyles.bodySmall.copyWith(color: AppColors.primaryBlue, fontWeight: FontWeight.w700, fontSize: 10)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: AppTextStyles.bodyLarge, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Text(details, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSlate), overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(amount, style: AppTextStyles.bodyLarge.copyWith(color: AppColors.primaryBlue)),
              ],
            ),
            const SizedBox(height: 16),
            Divider(color: Theme.of(context).dividerColor),
             const SizedBox(height: 12),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  Flexible(
                    child: Row(
                      children: [
                       const Icon(Icons.calendar_today_rounded, size: 14, color: AppColors.textLight),
                       const SizedBox(width: 6),
                       Flexible(child: Text(date, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textLight), overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                  ),
                   const Icon(Icons.chevron_right_rounded, size: 20, color: AppColors.textDark),
               ],
             ),
          ],
        ),
      ),
    );
  }
}
