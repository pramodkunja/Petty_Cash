import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background fallback
      body: Stack(
        children: [
          // 1. Full Screen Pages
          PageView.builder(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            itemCount: controller.onboardingData.length,
            itemBuilder: (context, index) {
              final data = controller.onboardingData[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  // Background Image
                  Image.network(
                    data['image'],
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(color: const Color(0xFF1E293B)); // Placeholder color
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: const Color(0xFF1E293B),
                      child: Center(child: Icon(Icons.image_not_supported, color: Colors.white24, size: 50.sp)),
                    ),
                  ),

                  // Gradient Overlay (Darkens bottom for text readability)
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(0.2),
                          const Color(0xFF0F172A).withOpacity(0.8), // Dark Blue/Slate
                          const Color(0xFF0F172A),
                        ],
                        stops: const [0.0, 0.4, 0.7, 1.0],
                      ),
                    ),
                  ),

                  // Content
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end, // Push content down
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (data['title'] == 'Expensify') ...[
                          // Specific styling for the first slide (Expensify Brand)
                          Text(
                            data['title'],
                            style: GoogleFonts.outfit(
                              fontSize: 48.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: -1.0,
                            ),
                          ),
                        ] else ...[
                          Text(
                            data['title'],
                            style: GoogleFonts.outfit(
                              fontSize: 40.sp, // Large headline
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.1,
                            ),
                          ),
                        ],
                        
                        SizedBox(height: 12.h),
                        
                        if ((data['subtitle'] as String).isNotEmpty) ...[
                          Text(
                            data['subtitle'],
                            style: GoogleFonts.inter(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          SizedBox(height: 16.h),
                        ],

                        Text(
                          data['description'],
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            color: Colors.white.withOpacity(0.8),
                            height: 1.5,
                          ),
                        ),
                        // Space for the bottom controls (Button + Dots)
                        SizedBox(height: 140.h), 
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          // 2. Top Right "Skip" Button (Floating)
          Positioned(
            top: MediaQuery.of(context).padding.top + 16.h,
            right: 16.w,
            child: Obx(() {
               if (controller.currentPage.value == 2) return const SizedBox.shrink();
               return GestureDetector(
                onTap: controller.skip,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2), // Glassmorphism pill
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Text(
                    'Skip onboarding', // Matches "Skip onboarding" pill
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }),
          ),

          // 3. Bottom Controls (Static)
          Positioned(
            bottom: 40.h,
            left: 24.w,
            right: 24.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Button
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: Obx(() {
                    bool isLast = controller.currentPage.value == 2;
                    return ElevatedButton(
                      onPressed: controller.nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366F1), // Indigo/Purple primary color from image
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r), // Rounded Pill
                        ),
                        elevation: 8,
                        shadowColor: const Color(0xFF6366F1).withOpacity(0.4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isLast ? AppText.getStarted : AppText.next,
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20.sp),
                        ],
                      ),
                    );
                  }),
                ),
                
                SizedBox(height: 24.h),

                // Dots Indicator
                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    controller.onboardingData.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      height: 8.h,
                      width: controller.currentPage.value == index ? 24.w : 8.w,
                      decoration: BoxDecoration(
                        color: controller.currentPage.value == index
                            ? const Color(0xFF818CF8) // Light Indigo Active
                            : Colors.white.withOpacity(0.2), // Inactive
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
