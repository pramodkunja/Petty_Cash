import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/app_text_styles.dart';
import '../../../../utils/app_colors.dart';

class RequestDetailsReadView extends StatelessWidget {
  const RequestDetailsReadView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> request = Get.arguments ?? {};
    
    // --- DEBUGGING START ---
    debugPrint("DEBUG: FULL REQUEST ARGS: $request");
    debugPrint("DEBUG: Attachments Field: ${request['attachments']}");
    if (request['attachments'] != null) {
      debugPrint("DEBUG: Attachments Type: ${request['attachments'].runtimeType}");
      if (request['attachments'] is List) {
         debugPrint("DEBUG: List Length: ${(request['attachments'] as List).length}");
         if ((request['attachments'] as List).isNotEmpty) {
           debugPrint("DEBUG: First Item: ${(request['attachments'] as List).first}");
           debugPrint("DEBUG: First Item Type: ${(request['attachments'] as List).first.runtimeType}");
         }
      }
    }
    // --- DEBUGGING END ---

    final String status = request['status'] ?? 'Pending';
    final String category = request['category'] ?? 'General';
    // Date Logic: Prefer 'created_at' for parsing, fallback to 'date'
    String dateStr = request['created_at']?.toString() ?? request['date']?.toString() ?? DateTime.now().toString();
    String date = dateStr;
    try {
      final DateTime dt = DateTime.parse(dateStr);
      final List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      date = '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
    } catch (e) {
      // If parsing fails, it might be already formatted or simple YYYY-MM-DD
       if (date.contains('T')) date = date.split('T')[0];
    }
    final String amount = (request['amount'] as double? ?? 0.0).toStringAsFixed(2);
    final String title = request['title'] ?? 'Request';

    // Status Styling
    final isApproved = status == 'Approved' || status == 'auto_approved';
    final statusColor = isApproved ? AppColors.successGreen : const Color(0xFFF59E0B);
    final statusBg = isApproved ? const Color(0xFFD1FAE5) : const Color(0xFFFEF3C7);
    final statusIcon = isApproved ? Icons.check_circle : Icons.pending;
    final statusText = isApproved ? 'Approved' : 'Pending';

    // Category Icon Logic
    IconData catIcon = Icons.category;
    if (category.toLowerCase().contains('food') || category.toLowerCase().contains('meal')) catIcon = Icons.restaurant;
    else if (category.toLowerCase().contains('travel')) catIcon = Icons.flight;
    else if (category.toLowerCase().contains('office')) catIcon = Icons.work;
    else if (category.toLowerCase().contains('transport')) catIcon = Icons.directions_car;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(AppText.requestDetails, style: AppTextStyles.h3.copyWith(color: AppColors.textDark)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.textDark),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Icon & Title Header
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F2FE),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(catIcon, size: 40, color: AppColors.primaryBlue),
              ),
              const SizedBox(height: 16),
              Text(title, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSlate, fontSize: 16)),
              
              // 2. Amount
              const SizedBox(height: 8),
              Text('₹$amount', style: AppTextStyles.h1.copyWith(fontSize: 48, letterSpacing: -1.0)),
              
              // 3. Status Pill
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, size: 16, color: statusColor),
                    const SizedBox(width: 8),
                    Text(statusText, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // 4. Info Grid (Category & Date)
              Row(
                children: [
                  Expanded(child: _buildInfoCard(context, 'Category', category, Icons.category)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildInfoCard(context, 'Date', date, Icons.calendar_today)),
                ],
              ),

              const SizedBox(height: 24),

              // 5. Description
              Align(alignment: Alignment.centerLeft, child: Text('Description', style: AppTextStyles.h3.copyWith(fontSize: 18))),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Text(
                  request['description'] ?? 'No description provided.',
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSlate, height: 1.5),
                ),
              ),

              const SizedBox(height: 24),

              // 6. Attachments
              Align(alignment: Alignment.centerLeft, child: Text('Attachments', style: AppTextStyles.h3.copyWith(fontSize: 18))),
              const SizedBox(height: 12),
              if (request['attachments'] != null && (request['attachments'] as List).isNotEmpty)
                 ListView.separated(
                   shrinkWrap: true,
                   physics: const NeverScrollableScrollPhysics(),
                   itemCount: (request['attachments'] as List).length,
                   separatorBuilder: (_, __) => const SizedBox(height: 12),
                   itemBuilder: (context, index) {
                     final attachment = (request['attachments'] as List)[index];
                     
                     String name = 'Attachment ${index + 1}';
                     String size = 'Unknown';
                     XFile? xFile;
                     String? url;

                     if (attachment is Map) {
                       name = attachment['name'] ?? name;
                       size = attachment['size']?.toString() ?? size;
                       
                       // Check for XFile (Local)
                       if (attachment['file'] is XFile) {
                         xFile = attachment['file'];
                         name = xFile?.name ?? name;
                       } 
                       // Check for URL Strings (Remote) under various keys
                       else {
                         url = attachment['file'] as String? ?? 
                               attachment['file_url'] as String? ?? 
                               attachment['url'] as String? ?? 
                               attachment['attachment'] as String? ??
                               attachment['path'] as String?;
                         
                         if (url != null) {
                           if (name == 'Attachment ${index + 1}') {
                             name = url!.split('/').last;
                           }
                         }
                       }
                     } else if (attachment is String) {
                       url = attachment;
                       name = url.split('/').last;
                     }

                     return Container(
                       padding: const EdgeInsets.all(16),
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(20),
                         boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
                         ],
                       ),
                       child: Row(
                         children: [
                           Container(
                             padding: const EdgeInsets.all(12),
                             decoration: BoxDecoration(
                               color: const Color(0xFFF3F4F6),
                               borderRadius: BorderRadius.circular(12),
                             ),
                             child: const Icon(Icons.insert_drive_file, color: Color(0xFFEF4444)),
                           ),
                           const SizedBox(width: 16),
                           Expanded(
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                                 const SizedBox(height: 4),
                                 Text(size, style: const TextStyle(color: AppColors.textSlate, fontSize: 12)),
                               ],
                             ),
                           ),
                           IconButton(
                             icon: const Icon(Icons.download, size: 20, color: AppColors.textSlate),
                             onPressed: () => _handleDownload(xFile, url, context),
                           )
                         ],
                       ),
                     );
                   },
                 )
              else 
                Text('No attachments', style: TextStyle(color: Colors.grey[400])),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
           BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: label == 'Category' ? const Color(0xFFE0E7FF) : const Color(0xFFF3E8FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: label == 'Category' ? const Color(0xFF4338CA) : const Color(0xFF7E22CE)),
          ),
          const SizedBox(height: 16),
          Text(label.toUpperCase(), style: const TextStyle(color: AppColors.textSlate, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(color: AppColors.textDark, fontSize: 16, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  void _handleDownload(XFile? file, String? url, BuildContext context) async {
    debugPrint("DEBUG: _handleDownload called");
    debugPrint("DEBUG: File: $file");
    debugPrint("DEBUG: URL: $url");
    
    try {
      if (file != null) {
        // Local File Logic
        if (kIsWeb) {
          await file.saveTo(file.name);
          Get.snackbar('Success', 'Download started', snackPosition: SnackPosition.BOTTOM);
        } else {
          final result = await OpenFile.open(file.path);
          if (result.type != ResultType.done) {
             Get.snackbar('Error', 'Could not open file: ${result.message}', snackPosition: SnackPosition.BOTTOM);
          }
        }
      } else if (url != null && url.isNotEmpty) {
        if (kIsWeb) {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
             await launchUrl(uri);
          }
        } else {
             // Mobile/Desktop Download
             await _downloadRemoteFile(url);
        }
      } else {
        Get.snackbar('Error', 'Attachment not available', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to handle attachment: $e', snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> _downloadRemoteFile(String url) async {
     try {
       // 1. Request Permission
       if (Platform.isAndroid || Platform.isIOS) {
          var status = await Permission.storage.status;
          if (!status.isGranted) {
             status = await Permission.storage.request();
          }
          if (Platform.isAndroid && await Permission.manageExternalStorage.status.isGranted) {
             // Android 11+ All Files Access
             status = PermissionStatus.granted; 
          }
           // Simple check - proceed even if denied on newer Androids as scoped storage might allow downloads
       }

       // 2. Get Directory
       Directory? dir;
       if (Platform.isAndroid) {
         dir = Directory('/storage/emulated/0/Download');
         if (!await dir.exists()) dir = await getExternalStorageDirectory();
       } else if (Platform.isIOS) {
         dir = await getApplicationDocumentsDirectory();
       } else {
         dir = await getDownloadsDirectory();
       }
       
       if (dir == null) {
         Get.snackbar('Error', 'Could not determine download path', snackPosition: SnackPosition.BOTTOM);
         return;
       }

       // 3. Prepare Path
       final fileName = url.split('/').last.split('?').first;
       final savePath = '${dir.path}/$fileName';
       
       Get.snackbar('Downloading', 'Downloading $fileName...', showProgressIndicator: true, snackPosition: SnackPosition.BOTTOM);

       // 4. Download
       await Dio().download(url, savePath);
       
       Get.snackbar(
         'Success', 
         'Saved to $savePath', 
         snackPosition: SnackPosition.BOTTOM,
         duration: const Duration(seconds: 5),
         mainButton: TextButton(
           onPressed: () => OpenFile.open(savePath),
           child: const Text('OPEN', style: TextStyle(color: AppColors.primaryBlue)),
         )
       );
       
     } catch (e) {
       Get.snackbar('Error', 'Download failed: $e', snackPosition: SnackPosition.BOTTOM);
     }
  }
}
