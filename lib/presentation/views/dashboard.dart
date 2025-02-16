import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zkdating/presentation/views/discover/discover.dart';
import 'package:zkdating/presentation/views/home/home.dart';
import 'package:zkdating/presentation/views/matches/matches.dart';
import 'package:zkdating/presentation/views/messages/messages.dart';

import '../../data/controllers/dashboard_controller.dart';

class Dashboard extends HookConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardController = ref.watch(dashBoardControllerProvider);
    final selectedPageIndex = dashboardController.myPage;

    final List<Widget> tabs = [
      const HomePage(),
      const Discover(),
      const PeopleMatch(),
      const PeopleMatch(),
      const Messages(),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          /// Display the selected page behind the bottom navigation bar
          Positioned.fill(child: tabs[selectedPageIndex]),

          /// Bottom Navigation Bar
          Positioned(
            bottom: 22.h, // Adjust the position as needed
            left: 15.w,
            right: 15.w,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 21.w),
              height: 64.h,
              width: 327.w,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(40),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
                borderRadius: BorderRadius.circular(40.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(iconList.length, (index) {
                  return InkWell(
                    onTap: () {
                      dashboardController.switchPage(index);
                      HapticFeedback.lightImpact();
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.fastLinearToSlowEaseIn,
                          height: index == selectedPageIndex ? 48.h : 0,
                          width: index == selectedPageIndex ? 48.h : 0,
                          decoration: BoxDecoration(
                            color: index == selectedPageIndex
                                ? const Color(0xFFDD88CF)
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SvgPicture.asset(
                          index == selectedPageIndex
                              ? filledIconList[index]
                              : iconList[index],
                          color: index == selectedPageIndex
                              ? null
                              : const Color(0xFF4B164C).withAlpha(150),
                          height: 24.sp,
                          width: 24.sp,
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static List<String> iconList = [
    'assets/svgs/home.svg',
    'assets/svgs/search.svg',
    'assets/svgs/add.svg',
    'assets/svgs/people.svg',
    'assets/svgs/messages.svg',
  ];

  static List<String> filledIconList = [
    'assets/svgs/home-filled.svg',
    'assets/svgs/search-filled.svg',
    'assets/svgs/add.svg',
    'assets/svgs/people-filled.svg',
    'assets/svgs/messages-filled.svg',
  ];
}
