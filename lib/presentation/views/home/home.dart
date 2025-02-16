import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zkdating/data/controllers/home_controller.dart';

import 'widgets/home_app_bar.dart';
import 'widgets/home_content.dart';
import 'widgets/home_stories.dart';
import 'widgets/tab_bar.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final activeTab = ref.watch(zkDatingHomeController);
    final homeController = ref.watch(zkDatingHomeController);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            homeAppBar(),
            SizedBox(height: 16.h),
            homeStorySection(),
            const SizedBox(height: 12),
            buildTabBar(ref, homeController),
            Expanded(
              child: homeContentSection(homeController.activeTab),
            ),
          ],
        ),
      ),
    );
  }
}
