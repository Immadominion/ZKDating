import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'notification_icon.dart';

Widget homeAppBar() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Friendzy',
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            color: Color(0xFF432B4F),
            fontFamily: 'Montserrat',
          ),
        ),
        NotificationIcon(hasNotification: true),
      ],
    ),
  );
}
