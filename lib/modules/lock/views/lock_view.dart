import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/services/biometric_service.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_styles.dart';
import '../../../../routes/app_routes.dart';

import 'dart:ui'; // For BackdropFilter

class LockView extends StatefulWidget {
  const LockView({Key? key}) : super(key: key);

  @override
  State<LockView> createState() => _LockViewState();
}

class _LockViewState extends State<LockView> {
  final BiometricService _biometricService = Get.find<BiometricService>();

  @override
  void initState() {
    super.initState();
    // Delay slightly to allow the view to build before showing biometric dialog
    Future.delayed(const Duration(milliseconds: 200), _authenticate);
  }

  Future<void> _authenticate() async {
    bool authenticated = await _biometricService.authenticate();
    if (authenticated) {
      Get.back(); // Pop the lock screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.85), // Dark overlay
        body: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Blur effect like PhonePe/GPay
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.lock_outline, size: 60, color: Colors.white),
                ),
                const SizedBox(height: 24),
                Text(
                  'App Locked',
                  style: AppTextStyles.h2.copyWith(color: Colors.white, letterSpacing: 1),
                ),
                const SizedBox(height: 12),
                Text(
                  'Unlock with Biometrics',
                  style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: _authenticate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 0,
                  ),
                  child: const Text('Unlock', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
