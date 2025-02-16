import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zkdating/data/controllers/home_controller.dart';

Widget buildTabBar(WidgetRef ref, HomePageController homeController) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Container(
      padding: EdgeInsets.all(4.sp),
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Stack(
        children: [
          // Animated background indicator
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: homeController.activeTab == 0 ? 0 : null,
            right: homeController.activeTab == 1 ? 0 : null,
            top: 0,
            bottom: 0,
            width: (MediaQuery.of(ref.context).size.width - 32 - 8.sp) /
                2, // (screen width - horizontal padding - container padding) / 2
            child: Container(
              decoration: BoxDecoration(
                color: Colors.purple[100],
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
          // Tab buttons row
          Row(
            children: [
              Expanded(
                child: TabButton(
                  title: 'Make Friends',
                  isActive: homeController.activeTab == 0,
                  onTap: () => homeController.activeTab = 0,
                ),
              ),
              Expanded(
                child: TabButton(
                  title: 'Search Partners',
                  isActive: homeController.activeTab == 1,
                  onTap: () => homeController.activeTab = 1,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class TabButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const TabButton({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              color: isActive ? Colors.purple[800] : Colors.grey[600],
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
            child: Text(title),
          ),
        ),
      ),
    );
  }
}
