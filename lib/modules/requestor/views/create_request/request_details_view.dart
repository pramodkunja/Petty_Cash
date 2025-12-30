import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Added
import '../../controllers/create_request_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/app_text_styles.dart';
import '../../../../utils/widgets/buttons/primary_button.dart';
import '../../../../utils/widgets/buttons/secondary_button.dart';

class RequestDetailsView extends GetView<CreateRequestController> {
  const RequestDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(AppText.requestDetails, style: AppTextStyles.h3),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textDark, size: 24.sp),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppText.amount, style: AppTextStyles.h2.copyWith(color: AppTextStyles.h2.color)),
              SizedBox(height: 12.h),
              TextField(
                controller: controller.amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                style: AppTextStyles.amountDisplay.copyWith(color: AppColors.textDark, fontSize: 32.sp),
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 8.w),
                    child: Text(
                      '₹',
                      style: AppTextStyles.amountDisplay.copyWith(color: AppColors.textDark, fontSize: 32.sp),
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide.none),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                ),
              ),
              SizedBox(height: 24.h),

              Text(AppText.requestType, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppTextStyles.h3.color)),
              SizedBox(height: 8.h),
              Obx(() => Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(30.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(controller.category.value, style: TextStyle(color: const Color(0xFF64748B), fontSize: 16.sp)),
                     IconButton(
                       icon: Icon(Icons.keyboard_arrow_down, color: const Color(0xFF64748B), size: 24.sp), 
                       onPressed: null
                     ),
                  ],
                ),
              )),
              
              SizedBox(height: 16.h),
              // Warning Banner
              Obx(() {
                if (controller.category.value == AppText.approvalRequired) {
                  return Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFBEB), // Yellow 50
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: const Color(0xFFFEF3C7)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: const BoxDecoration(color: Color(0xFFFDE68A), shape: BoxShape.circle),
                          child: Icon(Icons.warning_amber_rounded, color: const Color(0xFFB45309), size: 20.sp),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppText.approvalRequired, style: TextStyle(color: const Color(0xFF78350F), fontWeight: FontWeight.w700, fontSize: 14.sp)),
                            Text(AppText.approvalRequiredDesc, style: TextStyle(color: const Color(0xFF92400E), fontSize: 13.sp)),
                          ],
                        )),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
              SizedBox(height: 24.h),

              Text(AppText.category, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600, color: AppColors.textDark)),
              SizedBox(height: 8.h),
              Obx(() => Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Theme.of(context).dividerColor),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 8,
                      offset: Offset(0, 4.h),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Map<String, dynamic>>(
                    value: controller.selectedExpenseCategory.value,
                    hint: Text(AppText.selectCategory, style: AppTextStyles.hintText),
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down, color: AppColors.textSlate, size: 24.sp),
                    borderRadius: BorderRadius.circular(16.r),
                    dropdownColor: Theme.of(context).cardColor,
                    items: controller.expenseCategories.map((cat) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: cat,
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: AppColors.infoBg,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Icon(cat['icon'], color: AppColors.primaryBlue, size: 18.sp),
                            ),
                            SizedBox(width: 12.w),
                            Text(cat['name'], style: AppTextStyles.bodyMedium.copyWith(color: AppTextStyles.h3.color)),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (val) => controller.selectedExpenseCategory.value = val,
                  ),
                ),
              )),
              SizedBox(height: 24.h),

              Text(AppText.purpose, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600, color: AppColors.textDark)),
              SizedBox(height: 8.h),
              TextField(
                controller: controller.purposeController,
                decoration: InputDecoration(
                  hintText: AppText.purposeHint,
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide.none),
                  contentPadding: EdgeInsets.all(16.w),
                ),
              ),
              SizedBox(height: 24.h),

              Text(AppText.descriptionOptional, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600, color: AppColors.textDark)),
              SizedBox(height: 8.h),
              TextField(
                controller: controller.descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: AppText.descriptionPlaceholder,
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide.none),
                  contentPadding: EdgeInsets.all(16.w),
                ),
              ),
              SizedBox(height: 24.h),

              Row(
                children: [
                  Expanded(
                    child: SecondaryButton(
                      text: AppText.takePhoto,
                      onPressed: () => controller.pickImage(ImageSource.camera),
                      icon: Icon(Icons.camera_alt, color: AppColors.primaryBlue, size: 20.sp),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: SecondaryButton(
                      text: AppText.uploadBill,
                      onPressed: () => controller.pickImage(ImageSource.gallery),
                      icon: Icon(Icons.upload_file, color: AppColors.primaryBlue, size: 20.sp),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Obx(() => controller.attachedFiles.isNotEmpty 
                ? Column(
                    children: controller.attachedFiles.asMap().entries.map((entry) {
                      int idx = entry.key;
                      XFile file = entry.value;
                      return Container(
                        margin: EdgeInsets.only(bottom: 8.h),
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12.r), border: Border.all(color: Theme.of(context).dividerColor)),
                        child: Row(
                          children: [
                            Icon(Icons.description, color: const Color(0xFF64748B), size: 20.sp),
                            SizedBox(width: 8.w),
                            Expanded(child: Text(file.name, style: TextStyle(fontSize: 13.sp, color: AppTextStyles.bodyMedium.color), overflow: TextOverflow.ellipsis)),
                            IconButton(
                              icon: Icon(Icons.close, color: Colors.red, size: 20.sp),
                              onPressed: () => controller.removeFile(idx),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  )
                : const SizedBox.shrink()),

              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  text: AppText.reviewRequest,
                  onPressed: () {
                    if (controller.validateRequest()) {
                      Get.toNamed(AppRoutes.CREATE_REQUEST_REVIEW);
                    }
                  },
                  icon: Icon(Icons.check, color: Colors.white, size: 16.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
