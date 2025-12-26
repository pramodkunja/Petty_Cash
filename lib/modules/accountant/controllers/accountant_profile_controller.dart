import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../views/accountant_dashboard_view.dart';
import '../views/accountant_payments_view.dart';

class AccountantProfileController extends GetxController {
    // Mock Data
  final rxName = 'Sarah Jenkins'.obs;
  final rxEmail = 'sarah.jenkins@company.com'.obs;
  final rxPhone = '+1 123-456-7890'.obs;
  final rxRole = 'Accountant'.obs;

  void editProfile() {
    Get.toNamed(AppRoutes.EDIT_PROFILE);
  }

  void navigateToSettings() {
    Get.toNamed(AppRoutes.SETTINGS); // Resuing existing settings
  }

  void logout() {
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  void navigateToChangePassword() {
    Get.toNamed(AppRoutes.SETTINGS_CHANGE_PASSWORD); // Reusing existing
  }

  void onBottomNavTap(int index) {
     switch (index) {
      case 0:
        Get.offNamed(AppRoutes.ACCOUNTANT_DASHBOARD);
        break;
      case 1:
        Get.offNamed(AppRoutes.ACCOUNTANT_PAYMENTS);
        break;
      case 2:
        // Get.toNamed(AppRoutes.ACCOUNTANT_REPORTS);
        break;
      case 3:
        // Current
        break;
    }
  }
}
