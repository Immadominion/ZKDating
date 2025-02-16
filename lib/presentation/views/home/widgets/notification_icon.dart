import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/local/secure_storage_service.dart';
import '../../../../utils/locator.dart';

class NotificationIcon extends StatelessWidget {
  final bool hasNotification;

  const NotificationIcon({super.key, this.hasNotification = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await locator<SecureStorageService>().delete(
          key: 'user_email',
        );
      }, // Empty function
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// Outer Circle Border
          Container(
            width: 48.w, // Adjust as needed
            height: 48.h,
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.purple.withAlpha(20),
                width: 1.5.sp,
              ),
            ),
          ),

          /// Notification Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_outlined,
              color: Colors.purple,
              size: 24.sp,
            ),
          ),

          /// Notification Badge (only if there's a notification)
          if (hasNotification)
            Positioned(
              top: 20,
              right: 17,
              child: Container(
                width: 8.w,
                height: 8.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.purple,
                    width: .5,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 5.5.w,
                    height: 5.5.h,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD48AC1), // Badge color
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
