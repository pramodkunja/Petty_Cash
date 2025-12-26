import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../../../../core/services/storage_service.dart';

class OnboardingController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();
  final PageController pageController = PageController();
  
  final RxInt currentPage = 0.obs;
  
  // Define onboarding data
  // Define onboarding data
  final List<Map<String, dynamic>> onboardingData = [
    {
      'title': 'Expensify',
      'subtitle': 'Your Digital Expense Partner',
      'description': 'Effortless Expense Tracking for Modern Teams. Manage approvals, submit requests, and track spending in real-time.',
      'image': 'https://images.unsplash.com/photo-1563986768494-4dee2763ff3f?q=80&w=1000&auto=format&fit=crop', // Finance App on Phone
    },
    {
      'title': 'Streamlined\nApprovals',
      'subtitle': '',
      'description': 'Accelerate your workflow with instant reviews and seamless collaboration between teams.',
      'image': 'https://images.unsplash.com/photo-1586717791821-3f44a563fa4c?q=80&w=1000&auto=format&fit=crop', // Person checking phone/approving
    },
    {
      'title': 'Insightful\nReporting',
      'subtitle': '',
      'description': 'Real-time analytics for comprehensive financial control across your organization.',
      'image': 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?q=80&w=1000&auto=format&fit=crop', // Reliable Charts Image
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
