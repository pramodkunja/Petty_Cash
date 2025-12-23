import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/app_text_styles.dart';
import '../controllers/accountant_dashboard_controller.dart';
import 'widgets/accountant_bottom_bar.dart';
import 'cash_flow_history_view.dart';


class AccountantDashboardView extends GetView<AccountantDashboardController> {
  const AccountantDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                    children: [
                      Flexible(child: Text('${AppText.goodMorning},', style: AppTextStyles.h3)),
                      const SizedBox(width: 4),
                      Flexible(child: Text(AppText.mockAccountantName, style: AppTextStyles.h3)),
                    ],
                   ),
                  const SizedBox(height: 4),
                  Text(AppText.mockDate, style: AppTextStyles.bodySmall),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.notifications_outlined, color: AppColors.textDark),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AccountantBottomBar(
        currentIndex: 0,
        onTap: controller.onBottomNavTap,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // In-Hand Cash Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0EA5E9), Color(0xFF38BDF8)], // Sky Blue Gradient
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0EA5E9).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.account_balance_wallet_outlined, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        AppText.inHandCash,
                        style: AppTextStyles.bodyMedium.copyWith(color: Colors.white.withOpacity(0.9)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '₹4,250.00',
                      style: AppTextStyles.h1.copyWith(color: Colors.white), // Removed fixed fontSize
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                         const Icon(Icons.trending_up, color: Colors.white, size: 16),
                         const SizedBox(width: 4),
                         Flexible(
                           child: Text(
                            '+2.4% ${AppText.vsYesterday}',
                            style: AppTextStyles.bodySmall.copyWith(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                           ),
                         ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Balance Cards Row
            Row(
              children: [
                Expanded(
                  child: _buildBalanceCard(
                    context,
                    title: AppText.openBalance,
                    amount: '₹5,000.00',
                    icon: Icons.lock_clock_outlined,
                    iconBg: const Color(0xFFE0F2FE),
                    iconColor: AppColors.primaryBlue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildBalanceCard(
                    context,
                    title: AppText.closingBalance,
                    amount: '₹4,250.00',
                    icon: Icons.lock_outline,
                    iconBg: const Color(0xFFF3E8FF), // Purple 100
                    iconColor: const Color(0xFF9333EA), // Purple 600
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),

             // Amount In/Out Row
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                   Expanded(
                     child: _buildTransactionSummary(
                       icon: Icons.south_west_rounded,
                       iconBg: const Color(0xFFDCFCE7),
                       iconColor: AppColors.successGreen,
                       label: AppText.amountIn,
                       amount: '+₹500.00',
                     ),
                   ),
                   Container(height: 40, width: 1, color: Theme.of(context).dividerColor),
                   Expanded(
                     child: _buildTransactionSummary(
                       icon: Icons.north_east_rounded,
                       iconBg: const Color(0xFFFEE2E2),
                       iconColor: AppColors.errorRed,
                       label: AppText.amountOut,
                       amount: '-₹1,250.00',
                     ),
                   ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Pending Payments Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(24),
                 border: Border.all(color: AppColors.primaryBlue.withOpacity(0.3), width: 1),
                  boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryBlue.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppText.pendingPayments, style: AppTextStyles.h3),
                            const SizedBox(height: 4),
                            Text('5 ${AppText.paymentsNeedProcessing}', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSlate)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF7ED), // Orange 50
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.payments_rounded, color: AppColors.warningOrange),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.navigateToPayments,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppText.processPayments, style: AppTextStyles.buttonText.copyWith(color: Colors.white)),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_rounded, size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Today's Transactions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Text(AppText.todayTransactions, style: AppTextStyles.h3, overflow: TextOverflow.ellipsis)),
                TextButton(
                  onPressed: () => Get.to(() => const CashFlowHistoryView()), 
                  child: Text(AppText.viewAll, style: AppTextStyles.buttonText.copyWith(color: AppColors.primaryBlue)),
                ),
              ],
            ),
            const SizedBox(height: 16),
             _buildTransactionItem(
               context,
               title: 'Office Supplies',
               subtitle: 'Staples • 10:45 AM',
               amount: '-₹45.00',
               icon: Icons.print_rounded, // closest to printer/fax
             ),
             const SizedBox(height: 16),
             _buildTransactionItem(
               context,
               title: 'Client Lunch',
               subtitle: 'Panera • 12:30 PM',
               amount: '-₹85.00',
               icon: Icons.restaurant_rounded,
             ),
             const SizedBox(height: 16),
             _buildTransactionItem(
               context,
               title: 'Travel Expense',
               subtitle: 'Uber • 2:15 PM',
               amount: '-₹22.50',
               icon: Icons.directions_car_rounded,
             ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context, {
    required String title,
    required String amount,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBg, // Light Blue
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 16),
          Text(title, style: AppTextStyles.bodySmall.copyWith(fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(amount, style: AppTextStyles.h3), // Removed fixed fontSize
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionSummary({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String label,
    required String amount,
  }) {
    return Column(
      children: [
         Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 16),
          ),
          const SizedBox(height: 8),
          Text(label, style: AppTextStyles.bodySmall),
          const SizedBox(height: 4),
          FittedBox(fit: BoxFit.scaleDown, child: Text(amount, style: AppTextStyles.h3.copyWith(fontSize: 16))),
      ],
    );
  }

  Widget _buildTransactionItem(
      BuildContext context, {
      required String title,
      required String subtitle,
      required String amount,
      required IconData icon,
    }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark 
                ? Colors.white.withOpacity(0.05) 
                : const Color(0xFFF1F5F9),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.textSlate, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyLarge,
                  overflow: TextOverflow.ellipsis, // Prevent Title Overflow
                ), 
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSlate),
                  overflow: TextOverflow.ellipsis, // Prevent Subtitle Overflow
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(amount, style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textDark)),
        ],
      ),
    );
  }
}
