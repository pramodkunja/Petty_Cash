import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/app_text_styles.dart';
import '../../../../utils/widgets/buttons/primary_button.dart';
import '../controllers/admin_request_details_controller.dart';
import 'widgets/admin_app_bar.dart';

class AdminClarificationView extends GetView<AdminRequestDetailsController> {
  const AdminClarificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Controller is already put in previous screen, so we can access it.
    // However, if we need a text controller specifically for this view, we can add it to the controller or use a local one.
    // For now, let's assume the controller handles it or we use a local one and pass data back.
    // Actually, best practice with GetX is to put logic in controller.
    // I'll update controller to have clarification text controller.
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const AdminAppBar(title: AppText.askClarificationTitle),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppText.requestDetails, style: AppTextStyles.h3.copyWith(fontSize: 16)),
            const SizedBox(height: 12),
            // Request Summary Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() {
                          final req = controller.request;
                          final user = req['user']?.toString() ?? req['employee_name']?.toString() ?? req['created_by']?.toString() ?? 'Unknown User';
                          return Text(
                            user,
                            style: AppTextStyles.h3.copyWith(fontSize: 16),
                          );
                        }),
                        const SizedBox(height: 4),
                        Obx(() {
                           final req = controller.request;
                           final title = req['title']?.toString() ?? req['purpose']?.toString() ?? 'Expense';
                           return Text(
                            title,
                            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSlate),
                            maxLines: 2, 
                            overflow: TextOverflow.ellipsis,
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                   // Thumbnail or Icon
                   Obx(() {
                     final req = controller.request;
                     String? imageUrl;
                     if (req['receipt_url'] != null && req['receipt_url'].toString().isNotEmpty) {
                       imageUrl = req['receipt_url'].toString();
                     } else if (req['attachments'] is List && (req['attachments'] as List).isNotEmpty) {
                         final first = (req['attachments'] as List).first;
                         if (first is String) imageUrl = first;
                         if (first is Map) imageUrl = first['url'] ?? first['file'] ?? first['path'];
                     }
                     
                     if (imageUrl != null && (imageUrl.endsWith('.jpg') || imageUrl.endsWith('.png') || imageUrl.endsWith('.jpeg'))) {
                        return Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: NetworkImage(imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                     }
                     return Container(
                       height: 80,
                       width: 80,
                       decoration: BoxDecoration(
                         color: AppColors.primaryBlue.withOpacity(0.1),
                         borderRadius: BorderRadius.circular(12),
                       ),
                       child: Icon(Icons.receipt_long, color: AppColors.primaryBlue, size: 32),
                     );
                   }),
                ],
              ),
            ),
             const SizedBox(height: 12),
             Obx(() {
               final req = controller.request;
                final String amount = (req['amount'] is num) ? (req['amount'] as num).toStringAsFixed(2) : (req['amount']?.toString() ?? '0.00');
               return Container(
                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                 decoration: BoxDecoration(
                   color: Theme.of(context).primaryColor.withOpacity(0.1), // Light Blue
                   borderRadius: BorderRadius.circular(20),
                 ),
                 child: Text(
                   '₹$amount',
                   style: AppTextStyles.h3.copyWith(fontSize: 14, color: AppColors.primaryBlue),
                 ),
               );
             }),

            const SizedBox(height: 32),
            Text(AppText.yourQuestions, style: AppTextStyles.h3.copyWith(fontSize: 16)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Theme.of(context).dividerColor),
              ),
              child: TextField(
                controller: controller.clarificationController,
                maxLines: 6,
                decoration: const InputDecoration.collapsed(
                  hintText: AppText.clarificationHint,
                  hintStyle: TextStyle(color: AppColors.textSlate),
                ),
                style: AppTextStyles.bodyMedium,
              ),
            ),
            const SizedBox(height: 100), // Spacer for bottom
          ],
        ),
      ),
      bottomSheet: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.all(24),
        child: SafeArea(
          child: PrimaryButton(
            text: AppText.sendBackForClarification,
            onPressed: () => controller.submitClarification(),
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
