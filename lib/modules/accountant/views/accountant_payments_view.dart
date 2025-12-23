import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/app_text_styles.dart';
import '../controllers/accountant_dashboard_controller.dart';
import '../controllers/accountant_payments_controller.dart';
import 'tabs/completed_payments_tab.dart';
import 'tabs/pending_payments_tab.dart';
import 'widgets/accountant_bottom_bar.dart';

class AccountantPaymentsView extends GetView<AccountantPaymentsController> {
  const AccountantPaymentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false, // Prevent layout shift on keyboard
      bottomNavigationBar: AccountantBottomBar(
        currentIndex: 1,
        onTap: controller.onBottomNavTap, 
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false, // Remove back button
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Payment Requests', style: AppTextStyles.h2),
            const SizedBox(height: 4),
            Text('Accountant View', style: AppTextStyles.bodySmall),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded, color: AppColors.textDark),
            onPressed: () {},
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70), // Increased height for spacing
          child: Container(
             margin: const EdgeInsets.fromLTRB(20, 12, 20, 10), // Added top margin for space after Accountant View
             decoration: BoxDecoration(
               color: const Color(0xFFE2E8F0), 
               borderRadius: BorderRadius.circular(30),
             ),
             clipBehavior: Clip.antiAlias, // Ensure child (indicator) clips perfectly
             child: TabBar(
               controller: controller.tabController,
               indicatorSize: TabBarIndicatorSize.tab, // Fill the entire tab
               indicator: BoxDecoration(
                 color: AppColors.primaryBlue, // Blue to fill as requested
                 borderRadius: BorderRadius.circular(30),
                 // Remove Shadow if it looks like a "line"
               ),
               labelColor: Colors.white, 
               unselectedLabelColor: AppColors.textSlate,
               labelStyle: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
               unselectedLabelStyle: AppTextStyles.bodyMedium,
               dividerColor: Colors.transparent, // Remove any bottom line
               indicatorPadding: EdgeInsets.zero, // Ensure no padding
               labelPadding: EdgeInsets.zero, // Ensure full width tap target (optional, but good for fill)
               tabs: const [
                 Tab(text: 'Pending'),
                 Tab(text: 'Completed'),
               ],
             ),
          ),
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: const [
          PendingPaymentsTab(),
          CompletedPaymentsTab(),
        ],
      ),
    );
  }
}
