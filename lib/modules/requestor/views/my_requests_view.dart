import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/my_requests_controller.dart';
import '../../../../core/widgets/common_search_bar.dart';
import 'widgets/requestor_bottom_bar.dart'; 
import '../../../../utils/app_text.dart'; 
import '../../../../utils/app_text_styles.dart';
import '../../../../utils/app_colors.dart'; 

class MyRequestsView extends GetView<MyRequestsController> {
  const MyRequestsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(AppText.myRequests, style: TextStyle(color: AppTextStyles.h3.color, fontWeight: FontWeight.w700)),
        centerTitle: true,
        backgroundColor: Theme.of(context).cardColor, // White/Dark Card Color
        surfaceTintColor: Colors.transparent, // Remove material 3 tint
        elevation: 0,
        actions: const [], 
        automaticallyImplyLeading: false, 
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section (Search + Tabs)
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor, // Match AppBar
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
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
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                    child: CommonSearchBar(
                      hintText: AppText.searchRequests,
                      onChanged: controller.searchRequests,
                    ),
                  ),
      
                  // Tabs
                  Container(
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor, // Contrast for tab track
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Obx(() => Row(
                      children: [
                        _buildTab(context, AppText.filterAll, 0),
                        _buildTab(context, AppText.filterPending, 1),
                        _buildTab(context, AppText.filterApproved, 2),
                        _buildTab(context, AppText.filterRejected, 3),
                      ],
                    )),
                  ),
                ],
              ),
            ),

            // List

            // List
            Expanded(
              child: Obx(() => ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: controller.filteredRequests.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final req = controller.filteredRequests[index];
                  return _buildRequestCard(context, req);
                },
              )),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.CREATE_REQUEST_TYPE),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
 
    );
  }

  Widget _buildTab(BuildContext context, String title, int index) {
    bool isSelected = controller.currentTab.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isSelected ? Theme.of(context).cardColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)] : [],
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? AppColors.primaryBlue : AppTextStyles.bodyMedium.color,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRequestCard(BuildContext context, Map<String, dynamic> req) {
    Color statusColor;
    Color statusBg;
    
    switch (req['status']) {
      case 'Approved':
        statusColor = AppColors.successGreen;
        statusBg = AppColors.successBg;
        break;
      case 'Pending':
        statusColor = AppColors.warning;
        statusBg = AppColors.warning.withOpacity(0.1);
        break;
      case 'Rejected':
        statusColor = AppColors.error;
        statusBg = AppColors.error.withOpacity(0.1);
        break;
      default:
        statusColor = AppColors.textSlate;
        statusBg = AppColors.textSlate.withOpacity(0.1);
    }

    return GestureDetector(
      onTap: () => controller.viewDetails(req),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: req['iconBg'], borderRadius: BorderRadius.circular(12)),
              child: Icon(req['icon'], color: req['iconColor']),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(req['title'], style: AppTextStyles.h3.copyWith(fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(req['date'], style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSlate, fontSize: 13)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('₹${req['amount'].toStringAsFixed(2)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppTextStyles.h3.color)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(12)),
                  child: Text(req['status'], style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: statusColor)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
