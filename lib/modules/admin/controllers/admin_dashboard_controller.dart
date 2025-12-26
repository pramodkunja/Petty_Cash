import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';

class AdminDashboardController extends GetxController {
  final count = 0.obs;
  
  // Tab index for bottom bar
  final currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void changeTab(int index) {
    currentIndex.value = index;
  }

  void navigateToApprovals() {
    currentIndex.value = 1;
  }
}
