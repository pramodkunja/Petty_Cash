import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // Top Bar with Skip or Step Count
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Obx(() => controller.currentPage.value == 2 
            ? IconButton(
                icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
                onPressed: () => controller.pageController.previousPage(
                  duration: const Duration(milliseconds: 300), 
                  curve: Curves.easeInOut
                ),
              )
            : const SizedBox.shrink()
        ),
        actions: [
          Obx(() {
            if (controller.currentPage.value == 2) {
              return Padding(
                padding: const EdgeInsets.only(right: 20, top: 20),
                child: Text(
                  'Step 3/3',
                  style: GoogleFonts.inter(
                    color: AppColors.primaryBlue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            } else {
              return TextButton(
                onPressed: controller.skip,
                child: Text(
                  AppText.skip,
                  style: GoogleFonts.inter(
                    color: AppColors.textSlate,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }
          }),
        ],
      ),
      body: Column(
        children: [
          // Page Content
          Expanded(
            child: PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.onPageChanged,
              itemCount: controller.onboardingData.length,
              itemBuilder: (context, index) {
                final data = controller.onboardingData[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image / Illustration Placeholder
                      Expanded(
                        flex: 3,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2E5C55), // Teal/Greenish specific to design 1/2 or Dark Blue for 3
                             gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: index == 0 
                                ? [const Color(0xFF3B6B64), const Color(0xFF2E4F4A)] // Teal-ish
                                : index == 1
                                    ? [const Color(0xFF4B7B6E), const Color(0xFF3E6359)] // Green-ish
                                    : [const Color(0xFF1E293B), const Color(0xFF0F172A)], // Dark Blue
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            // Placeholder Icon until asset is available
                            child: Icon(
                              data['icon'], 
                              size: 100, 
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      
                      // Title & Description
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Text(
                              data['title'],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              data['description'],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: AppColors.textSlate,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          
          // Bottom Controls
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
            child: Column(
              children: [
                // Dots Indicator
                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    controller.onboardingData.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: controller.currentPage.value == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color: controller.currentPage.value == index
                            ? AppColors.primaryBlue
                            : AppColors.borderLight,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                )),
                const SizedBox(height: 32),
                
                // Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: Obx(() {
                    bool isLast = controller.currentPage.value == 2;
                    return ElevatedButton(
                      onPressed: controller.nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isLast ? AppText.getStarted : AppText.next,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
                        ],
                      ),
                    );
                  }),
                ),
                
                // Terms Text (Last Page Only)
                Obx(() => controller.currentPage.value == 2
                    ? Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          AppText.onboardingTerms,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppColors.textSlate,
                          ),
                        ),
                      )
                    : const SizedBox(height: 0) // Maintain layout stability or shrink
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
