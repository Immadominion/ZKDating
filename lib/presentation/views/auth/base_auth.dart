import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zkdating/core/extensions/widget_extension.dart';
import 'package:zkdating/data/controllers/reclaim_auth_controller.dart';
import 'package:zkdating/data/services/reclaim_auth_service.dart';
import 'package:zkdating/presentation/views/auth/widgets/auth_buttons.dart';
import 'package:zkdating/presentation/views/auth/widgets/cta_text.dart';


class BaseAuth extends ConsumerWidget {
  const BaseAuth({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 64.h),
                Image.asset(
                  'assets/images/Group.png',
                  height: 306.h,
                  width: 311.w,
                ).afmPadding(EdgeInsets.symmetric(horizontal: 12.w)),
                SizedBox(height: 26.h),
                Text(
                  "Meet new people around you",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: CustomElevatedButton(
                        onPressed: () {
                          ref
                              .read(reclaimAuthController.notifier)
                              .signInWithProvider(AuthProvider.warpcast);
                        },
                        text: "Verify with Warpcast",
                        iconPath: 'assets/images/warpcast.png',
                        textColor: Colors.white,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      flex: 1,
                      child: CustomElevatedButton(
                        onPressed: () {
                          ref
                              .read(reclaimAuthController.notifier)
                              .signInWithProvider(AuthProvider.x);
                        },
                        iconPath: 'assets/images/x.png',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomElevatedButton(
                        onPressed: () {},
                        iconPath: 'assets/images/linkedIn.jpg',
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      flex: 3,
                      child: CustomElevatedButton(
                        onPressed: () {
                          ref
                              .read(reclaimAuthController.notifier)
                              .signInWithProvider(AuthProvider.google);
                        },
                        text: "Verify with Google",
                        iconPath: 'assets/svgs/google.svg',
                        buttonColor: const Color(0xFFDD88CF),
                        textColor: const Color(0xFF4B164C),
                        isIconSvg: true,
                      ),
                    ),
                  ],
                ),
                CTAText(onTap: () {})
                    .afmPadding(EdgeInsets.only(top: 32.h, bottom: 12.h)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
