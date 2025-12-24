import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_styles.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use a custom darker blue for the logo to match the "Expensify" reference if needed, 
    // or use primaryBlue for consistency. Reference uses a bright blue icon.
    final Color logoBlue = AppColors.primaryBlue;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Background Gradient (Subtle)
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0, -0.2),
                radius: 1.5,
                colors: [
                  Theme.of(context).brightness == Brightness.light
                      ? Colors.blue.withOpacity(0.05)
                      : Colors.blue.withOpacity(0.02),
                  Theme.of(context).scaffoldBackgroundColor,
                ],
              ),
            ),
          ),
          
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Logo
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeOutBack,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Opacity(
                        opacity: value.clamp(0.0, 1.0),
                        child: child,
                      ),
                    );
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: logoBlue.withOpacity(0.2),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.account_balance_wallet_rounded, 
                      size: 50, 
                      color: logoBlue,
                    ),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Animated Text
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Text(
                        'Petty Cash', // Using App Name
                        style: AppTextStyles.h1.copyWith(
                          fontSize: 32,
                          letterSpacing: -0.5,
                          // color: theme handled by app text styles usually, but ensuring
                          color: Theme.of(context).textTheme.bodyLarge?.color, 
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Efficient financial management for\nmodern teams.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSlate,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Bottom Loading Indicator
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  // Progress Bar
                  SizedBox(
                    width: 200,
                    child: Obx(() => ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: controller.progress.value,
                        backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
                        minHeight: 6,
                      ),
                    )),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'LOADING DASHBOARD',
                    style: AppTextStyles.bodySmall.copyWith(
                      letterSpacing: 1.5,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSlate,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
