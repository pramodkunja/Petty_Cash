import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/app_text_styles.dart';

class AccountantBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AccountantBottomBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).cardColor,
          selectedItemColor: AppColors.primaryBlue,
          unselectedItemColor: AppTextStyles.bodySmall.color,
          selectedLabelStyle: AppTextStyles.bodyMedium.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
          unselectedLabelStyle: AppTextStyles.bodyMedium.copyWith(fontSize: 12),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: AppText.navHome,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.payments_outlined),
              label: AppText.navPayments,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded),
              label: AppText.navReports,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: AppText.settings,
            ),
          ],
        ),
      ),
    );
  }
}
