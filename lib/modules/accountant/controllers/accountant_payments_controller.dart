import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../routes/app_routes.dart';

class AccountantPaymentsController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void onBottomNavTap(int index) {
      switch (index) {
      case 0:
        Get.offNamed(AppRoutes.ACCOUNTANT_DASHBOARD);
        break;
      case 1:
        // Current
        break;
      case 2:
        // Get.toNamed(AppRoutes.ACCOUNTANT_REPORTS);
        break;
      case 3:
        Get.offNamed(AppRoutes.ACCOUNTANT_PROFILE);
        break;
    }
  }
}
