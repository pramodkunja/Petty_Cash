import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Added
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/app_text_styles.dart';
import '../../controllers/payment_flow_controller.dart'; // Correct relative import

class BillDetailsView extends GetView<PaymentFlowController> {
  const BillDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.isQrDetected.isFalse) {
        // Only start if not already detected
        controller.startQrSimulation();
      }
    });

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24.sp,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'INV-2023-001.pdf',
          style: AppTextStyles.h3.copyWith(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.black,
              size: 24.sp,
            ),
            onPressed: () {},
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Main Content (Bill Preview)
          Positioned.fill(
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 4.0,
              child: Center(
                child: Container(
                  width: 0.9.sw,
                  // Remove fixed height to allow InteractiveViewer to handle it nicely
                  // height: MediaQuery.of(context).size.height * 0.7,
                  constraints: BoxConstraints(
                    maxHeight: 0.8.sh,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.1),
                        blurRadius: 20.r,
                      )
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Bill Placeholder / Image
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.receipt_long_rounded,
                              size: 100.sp,
                              color: Colors.grey.shade300,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'Invoice #INV-2023-001',
                              style: AppTextStyles.h2.copyWith(
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Tap to Zoom',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Scanning Animation Overlay - Wrapped in IgnorePointer to allow Zooming
                      if (controller.isQrDetected.isFalse)
                        Positioned.fill(
                          child: IgnorePointer(child: ScannerAnimation()),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Obx(() {
            if (controller.isQrDetected.isTrue) {
              return _buildQrDetectedPopup();
            } else {
              return const SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }

  Widget _buildQrDetectedPopup() {
    return DraggableScrollableSheet(
      initialChildSize: 0.45,
      minChildSize: 0.2,
      maxChildSize: 0.6,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          padding: EdgeInsets.all(24.w),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F7FA),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: const Color(0xFFB2EBF2)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.qr_code_scanner,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppText.paymentDetailsFound,
                              style: AppTextStyles.bodyLarge.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              AppText.scannedFromQr,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSlate,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.check_circle,
                        color: AppColors.primaryBlue,
                        size: 24.sp,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                _buildDetailRow(
                  AppText.payeeName,
                  'Office Supplies Co.',
                  boldValue: true,
                ),
                Divider(height: 24.h),
                _buildDetailRow(AppText.upiId, 'office.supplies@upi'),
                Divider(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppText.amount,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSlate,
                      ),
                    ),
                    Text(
                      '₹145.00',
                      style: AppTextStyles.h1.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.onUseForPayment();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1aa3df), // Primary Blue
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppText.useForPayment,
                          style: AppTextStyles.buttonText.copyWith(
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(Icons.arrow_forward, color: Colors.white, size: 24.sp),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Center(
                  child: TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      AppText.dismiss,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSlate,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value, {bool boldValue = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.primaryBlue,
          ),
        ),
        Text(
          value,
          style: boldValue
              ? AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w700)
              : AppTextStyles.bodyMedium,
        ),
      ],
    );
  }
}

class ScannerAnimation extends StatefulWidget {
  const ScannerAnimation({super.key});

  @override
  State<ScannerAnimation> createState() => _ScannerAnimationState();
}

class _ScannerAnimationState extends State<ScannerAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: ScannerPainter(_animation.value),
          child: Container(),
        );
      },
    );
  }
}

class ScannerPainter extends CustomPainter {
  final double position;

  ScannerPainter(this.position);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green.withOpacity(0.5)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final y = size.height * position;

    // Draw scanning line
    canvas.drawLine(
      Offset(0, y),
      Offset(size.width, y),
      paint..color = Colors.green,
    );

    // Draw gradient glow below line
    final gradientRect = Rect.fromLTWH(0, y, size.width, 50.h);
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.green.withOpacity(0.3), Colors.transparent],
    );

    final glowPaint = Paint()..shader = gradient.createShader(gradientRect);
    canvas.drawRect(gradientRect, glowPaint);
  }

  @override
  bool shouldRepaint(covariant ScannerPainter oldDelegate) {
    return oldDelegate.position != position;
  }
}
