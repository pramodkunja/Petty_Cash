import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_styles.dart';
import '../controllers/provide_clarification_controller.dart';


class ProvideClarificationView extends GetView<ProvideClarificationController> {
  const ProvideClarificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Colors from design
    final Color tealColor = const Color(0xFF0F9D88); 
    final Color amberBg = const Color(0xFFFFFBEB);
    final Color amberBorder = const Color(0xFFFCD34D);
    final Color amberIcon = const Color(0xFFD97706);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Light grey bg
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, size: 20.sp),
                       onPressed: () => Get.back(),
                    ),
                    Text(
                      "PROVIDE CLARIFICATION",
                      style: AppTextStyles.h3.copyWith(fontSize: 14.sp, color: AppColors.textSlate, letterSpacing: 1.2),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, size: 24.sp),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
              ),

              // White Card Section
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 24.w),
                padding: EdgeInsets.symmetric(vertical: 32.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20.r,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Icon
                    Container(
                      height: 64.h,
                      width: 64.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFECFDF5), // Light Mint
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Icon(Icons.lunch_dining, color: tealColor, size: 32.sp), 
                    ),
                    SizedBox(height: 16.h),
                    
                    // Request ID Tag
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundLight,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Obx(() {
                        final id = controller.request['request_id'] ?? controller.request['id'] ?? 'PC-2023-891';
                        return Text("Request #$id", style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSlate));
                      }),
                    ),
                    SizedBox(height: 12.h),
                    
                    // Title
                    Obx(() => Text(
                      controller.request['title']?.toString() ?? "Team Lunch",
                      style: AppTextStyles.h3.copyWith(fontSize: 18.sp, color: AppColors.textSlate),
                    )),
                    SizedBox(height: 8.h),
                    
                    // Amount
                     Obx(() {
                       final amount = controller.request['amount']?.toString() ?? "124.00";
                       return Text(
                        "\$$amount",
                        style: AppTextStyles.h1.copyWith(fontSize: 36.sp, color: AppColors.textDark, fontWeight: FontWeight.bold),
                      );
                     }),
                  ],
                ),
              ),

              SizedBox(height: 32.h),

              // Alert Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(
                       children: [
                         Icon(Icons.error_outline, color: amberIcon, size: 20.sp),
                         SizedBox(width: 8.w),
                         Text("CLARIFICATION REQUESTED", style: AppTextStyles.h3.copyWith(fontSize: 12.sp, color: AppColors.textSlate)),
                       ],
                     ),
                     SizedBox(height: 12.h),
                     Container(
                       padding: EdgeInsets.all(20.w),
                       decoration: BoxDecoration(
                         color: amberBg,
                         borderRadius: BorderRadius.circular(16.r),
                         border: Border.all(color: amberBorder),
                       ),
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Container(
                             padding: EdgeInsets.all(8.w),
                             decoration: BoxDecoration(
                               color: const Color(0xFFFEF3C7),
                               shape: BoxShape.circle,
                             ),
                             child: Icon(Icons.person_outline, color: amberIcon, size: 20.sp),
                           ),
                           SizedBox(width: 16.w),
                           Expanded(
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text("Approver Question", style: AppTextStyles.bodyMedium.copyWith(color: amberIcon, fontWeight: FontWeight.bold)),
                                 SizedBox(height: 8.h),
                                 Obx(() => Text(
                                   controller.request['admin_remarks'] ?? '"The attached receipt total (\$118.00) doesn\'t match the requested amount (\$124.00). Please explain the difference or update the amount."',
                                   style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textDark, height: 1.5),
                                 )),
                               ],
                             ),
                           )
                         ],
                       ),
                     ),
                  ],
                ),
              ),

               SizedBox(height: 24.h),

               // Response Field
               Padding(
                 padding: EdgeInsets.symmetric(horizontal: 24.w),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text("YOUR RESPONSE", style: AppTextStyles.h3.copyWith(fontSize: 12.sp, color: AppColors.textSlate)),
                     SizedBox(height: 12.h),
                     Container(
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(16.r),
                         border: Border.all(color: AppColors.borderLight),
                         boxShadow: [
                           BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2)),
                         ],
                       ),
                       child: TextField(
                         controller: controller.responseController,
                         maxLines: 4,
                         decoration: InputDecoration(
                           hintText: "Type your explanation here...",
                           hintStyle: TextStyle(color: AppColors.textLight),
                           border: InputBorder.none,
                           contentPadding: EdgeInsets.all(20.w),
                         ),
                       ),
                     ),
                   ],
                 ),
               ),

               SizedBox(height: 32.h),
               
               // Actions
               Padding(
                 padding: EdgeInsets.symmetric(horizontal: 24.w),
                 child: Column(
                   children: [
                     SizedBox(
                       width: double.infinity,
                       height: 56.h,
                       child: ElevatedButton(
                         onPressed: () => controller.submitClarification(),
                         style: ElevatedButton.styleFrom(
                           backgroundColor: tealColor,
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                           elevation: 4,
                           shadowColor: tealColor.withOpacity(0.4),
                         ),
                         child: Obx(() => controller.isLoading.value 
                           ? const CircularProgressIndicator(color: Colors.white)
                           : Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Text("Submit Clarification", style: AppTextStyles.h3.copyWith(color: Colors.white, fontSize: 16.sp)),
                               SizedBox(width: 8.w),
                               Icon(Icons.send_rounded, color: Colors.white, size: 20.sp),
                             ],
                           )),
                       ),
                     ),
                     SizedBox(height: 16.h),
                     TextButton(
                       onPressed: () => Get.back(),
                       child: Text("Cancel", style: AppTextStyles.h3.copyWith(color: AppColors.textSlate, fontSize: 16.sp)),
                     ),
                   ],
                 ),
               ),
               SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}
