import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../routes/app_routes.dart';

class PaymentFlowController extends GetxController {

  // State
  final RxBool isQrDetected = false.obs;
  final RxString selectedPaymentSource = 'Bank Transfer / UPI'.obs; // Default to Digital
  final RxString selectedPaymentApp = ''.obs;

  // ... existing code ...

  void onPayViaUpi() async {
    if (selectedPaymentApp.isEmpty) {
      Get.snackbar('Error', 'Please select a payment app');
      return;
    }

    // Handle Custom/Manual Payment
    if (selectedPaymentApp.value == 'Custom') {
      _handleCustomPayment();
      return;
    }
    
    // Construct UPI URI
    final upiUri = Uri.parse(
      'upi://pay?pa=9490997946@hdfc&pn=Office%20Supplies%20Co.&am=${finalAmount.value}&cu=INR&tn=Invoice%20Inv-2023-001'
    );

    try {
      // Attempt to launch directly. canLaunchUrl can be flaky on Android 11+ depending on queries.
      // We rely on the OS to handle the intent or throw.
      bool launched = await launchUrl(
        upiUri, 
        mode: LaunchMode.externalApplication,
      );
      
      if (!launched) {
        throw 'Could not launch UPI intent';
      }
      
      // If launched successfully, ask for confirmation
      Get.dialog(
        AlertDialog(
          title: const Text('Payment Confirmation'),
          content: const Text('Did you complete the payment successfully in the UPI app?'),
          actions: [
             TextButton(
              onPressed: () => Get.back(), // Stay on page
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back(); // Close dialog
                Get.offNamed(AppRoutes.ACCOUNTANT_PAYMENT_SUCCESS);
              },
              child: const Text('Yes, Payment Done'),
            ),
          ],
        ),
        barrierDismissible: false,
      );

    } catch (e) {
      print('Error launching UPI: $e');
      // Navigate to Payment Failed Screen
      Get.toNamed(AppRoutes.ACCOUNTANT_PAYMENT_FAILED);
    }
  }

  void _handleCustomPayment() {
    final txnController = TextEditingController();
    Get.dialog(
      AlertDialog(
        title: const Text('Enter Transaction Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Please enter the Transaction ID (Reference No.) from your payment app.'),
            const SizedBox(height: 16),
            TextField(
              controller: txnController,
              decoration: const InputDecoration(
                labelText: 'Transaction ID',
                border: OutlineInputBorder(),
                hintText: 'e.g., UPI-123456789',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (txnController.text.isEmpty) {
                Get.snackbar('Required', 'Please enter Transaction ID');
                return;
              }
              Get.back(); // Close dialog
              Get.offNamed(AppRoutes.ACCOUNTANT_PAYMENT_SUCCESS);
            },
            child: const Text('Confirm Payment'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
  
  // Scenarios
  // To simulate Scenario 1 (QR Detected) vs Scenario 2 (No QR), 
  // we can toggle this bool or randomize it. 
  // For demo purposes, we'll set it to TRUE by default, 
  // or use a flag passed from arguments.
  bool shouldSimulateQrDetection = true; 

  // Payment Logic
  final RxDouble requestedAmount = 150.00.obs;
  final RxDouble finalAmount = 150.00.obs;
  final adjustmentController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Check arguments if any
    if (Get.arguments != null) {
      if (Get.arguments is Map) {
        shouldSimulateQrDetection = Get.arguments['simulateQr'] ?? true;
      }
    }
  }

  @override
  void onClose() {
    adjustmentController.dispose();
    super.onClose();
  }

  // Called when Bill Details screen is opened
  void startQrSimulation() async {
    if (!shouldSimulateQrDetection) return;

    // Reset first
    isQrDetected.value = false;

    // Simulate delay
    await Future.delayed(const Duration(seconds: 2)); // 1.5 - 2s delay
    isQrDetected.value = true;
  }

  void onUseForPayment() {
    Get.toNamed(AppRoutes.ACCOUNTANT_PAYMENT_VERIFY);
  }

  void selectPaymentSource(String source) {
    selectedPaymentSource.value = source;
  }

  void onMakePayment() {
    if (selectedPaymentSource.isEmpty) {
      Get.snackbar('Error', 'Please select a payment source');
      return;
    }
    Get.toNamed(AppRoutes.ACCOUNTANT_PAYMENT_CONFIRM);
  }

  void selectPaymentApp(String appName) {
    selectedPaymentApp.value = appName;
  }

  void backToDashboard() {
    Get.offAllNamed(AppRoutes.ACCOUNTANT_DASHBOARD);
  }
}
