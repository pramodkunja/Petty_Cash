import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../../../../core/services/storage_service.dart';

class OnboardingController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();
  final PageController pageController = PageController();
  
  final RxInt currentPage = 0.obs;
  
  // Define onboarding data
  final List<Map<String, dynamic>> onboardingData = [
    {
      'title': 'Effortless Expense\nTracking', // Using keys or direct strings if preferred, referencing for clarity
      'description': 'Capture receipts, submit reports, and track your budget instantly. Expense management made simple.',
      'image': 'assets/images/onboarding_1.png', // Placeholder path
      'icon': Icons.savings_rounded, // Fallback icon
    },
    {
      'title': 'Quick Approvals\n& Payments',
      'description': 'Streamline your workflow. Review expenses and authorize payments instantly with just one tap.',
      'image': 'assets/images/onboarding_2.png',
      'icon': Icons.security_rounded,
    },
    {
      'title': 'Manage Finances\nYour Way',
      'description': 'Tailored dashboards for every role. From submitting expenses to auditing reports, experience seamless financial control.',
      'image': 'assets/images/onboarding_3.png',
      'icon': Icons.dashboard_rounded,
    },
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < onboardingData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      finishOnboarding();
    }
  }

  void skip() {
    finishOnboarding();
  }

  Future<void> finishOnboarding() async {
    await _storageService.write('has_seen_onboarding', 'true');
    Get.offAllNamed(AppRoutes.LOGIN);
  }
}
