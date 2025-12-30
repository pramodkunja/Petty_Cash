import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Added
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
        title: Text(AppText.myRequests, style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.w700)),
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
            // Header Section (Search + Tabs)
            Container(
              clipBehavior: Clip.hardEdge, // Prevent tabs from overlapping rounded corners
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor, 
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.r)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20.r, offset: Offset(0, 8.h)),
                ],
              ),
              child: Column(
                children: [
                   SizedBox(height: 8.h),
                  // Search Bar
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                    child: CommonSearchBar(
                      hintText: AppText.searchRequests,
                      onChanged: controller.searchRequests,
                    ),
                  ),
                  
                  SizedBox(height: 8.h),

                  // Scrollable Tab Pills
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                    child: Obx(() => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildTab(context, AppText.filterAll, 0),
                        SizedBox(width: 12.w),
                        _buildTab(context, AppText.filterPending, 1),
                        SizedBox(width: 12.w),
                        _buildTab(context, AppText.filterApproved, 2),
                        SizedBox(width: 12.w),
                        _buildTab(context, AppText.filterRejected, 3),
                        SizedBox(width: 12.w),
                        _buildTab(context, 'Unpaid', 4),
                      ],
                    )),
                  ),
                ],
              ),
            ),

            // List
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                if (controller.filteredRequests.isEmpty) {
                  return Center(child: Text('No requests found', style: TextStyle(color: AppColors.textSlate)));
                }

                return ListView.separated(
                  padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 100.h), // Extra bottom padding for FAB
                  itemCount: controller.filteredRequests.length,
                  separatorBuilder: (_, __) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final req = controller.filteredRequests[index];
                    return _buildRequestCard(context, req);
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.CREATE_REQUEST_TYPE),
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add, color: Colors.white, size: 24.sp),
      ),
 
    );
  }

  Widget _buildTab(BuildContext context, String title, int index) {
    bool isSelected = controller.currentTab.value == index;
    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : AppColors.textSlate.withOpacity(0.2), 
            width: 1.5
          ),
          boxShadow: isSelected ? [
            BoxShadow(color: AppColors.primaryBlue.withOpacity(0.3), blurRadius: 8.r, offset: Offset(0, 4.h))
          ] : [],
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? Colors.white : AppColors.textSlate,
          ),
        ),
      ),
    );
  }

  Widget _buildRequestCard(BuildContext context, Map<String, dynamic> req) {
    Color statusColor;
    Color statusBg;
    
    final status = req['status']?.toString().toLowerCase() ?? 'pending';
    
    if (status == 'approved' || status == 'auto_approved') {
        statusColor = AppColors.successGreen;
        statusBg = AppColors.successBg;
    } else if (status == 'pending') {
        statusColor = AppColors.warning;
        statusBg = AppColors.warning.withOpacity(0.1);
    } else if (status == 'rejected') {
        statusColor = AppColors.error;
        statusBg = AppColors.error.withOpacity(0.1);
    } else {
        statusColor = AppColors.textSlate;
        statusBg = AppColors.textSlate.withOpacity(0.1);
    }

    // Determine Status Text
    String statusText = status.capitalizeFirst!;
     if (status == 'auto_approved') statusText = 'Approved';

    return GestureDetector(
      onTap: () => controller.viewDetails(req),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10.r, offset: Offset(0, 4.h))],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(color: req['iconBg'], borderRadius: BorderRadius.circular(12.r)),
              child: Icon(req['icon'], color: req['iconColor'], size: 24.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(req['purpose'] ?? req['title'] ?? 'Request', style: AppTextStyles.h3.copyWith(fontSize: 16.sp)),
                  SizedBox(height: 4.h),
                  Text(req['date'] ?? 'No Date', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSlate, fontSize: 13.sp)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('₹${(req['amount'] as num?)?.toStringAsFixed(2) ?? "0.00"}', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: AppTextStyles.h3.color)),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(12.r)),
                  child: Text(statusText, style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600, color: statusColor)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
