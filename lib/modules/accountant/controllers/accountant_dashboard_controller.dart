import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/app_colors.dart';
import '../views/widgets/update_balances_dialog.dart';

class AccountantDashboardController extends GetxController {
  
  @override
  void onReady() {
    super.onReady();
    _checkDailyBalanceUpdate();
  }

  Future<void> _checkDailyBalanceUpdate() async {
    // 1. Get today's date formatted as YYYY-MM-DD
    final now = DateTime.now();
    final todayStr = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    // 2. Check Storage
    const storage = FlutterSecureStorage();
    final lastUpdate = await storage.read(key: 'last_balance_update_date');

    if (lastUpdate != todayStr) {
       // Show dialog if not updated today
       Future.delayed(const Duration(seconds: 1), () {
          _showUpdateBalanceDialog(todayStr, storage);
       });
    }
  }

  void _showUpdateBalanceDialog(String todayStr, FlutterSecureStorage storage) {
    final amountController = TextEditingController(); 
    
    Get.dialog(
      UpdateBalancesDialog(
        controller: amountController,
        onSave: () async {
            // Write today's date to storage so it doesn't show again today
            await storage.write(key: 'last_balance_update_date', value: todayStr);
            
            Get.back();
            Get.snackbar(
              'Success', 
              'Opening balance updated for today', 
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: AppColors.successGreen,
              colorText: Colors.white,
              margin: const EdgeInsets.all(20),
            );
        },
        onCancel: () {
          // You might want to force update or just close. 
          // If we want to force it, we wouldn't update storage here.
          // Assuming cancel allows skipping for now.
          Get.back();
        },
      ),
      barrierDismissible: false,
    );
  }

  final rxIndex = 0.obs;

  void changeTabIndex(int index) {
    rxIndex.value = index;
  }

  void navigateToPayments() {
    changeTabIndex(1);
  }

  void onBottomNavTap(int index) {
    rxIndex.value = index;
  }
}
