import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';
import 'package:zkdating/core/extensions/widget_extension.dart';

Widget homeContentSection(int activeTab) {
  return ListView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: 5,
    itemBuilder: (context, index) => homeContentCard(),
  ).afmBorderRadius(
    BorderRadius.only(
      bottomLeft: Radius.circular(70.r),
      bottomRight: Radius.circular(70.r),
    ),
  );
}

Widget homeContentCard() {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(32),
      color: Colors.grey[200],
    ),
    clipBehavior: Clip.antiAlias,
    child: Stack(
      children: [
        // Background Image
        Image.network(
          'https://picsum.photos/400/300',
          height: 230.h,
          width: 330.w,
          fit: BoxFit.cover,
        ),
        // Gradient Overlay
        Container(
          height: 230.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.2),
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
        ),
        // Travel Tag
        Positioned(
          top: 16.h,
          left: 16.w,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.h,
                  vertical: 8.w,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Image.network(
                      'https://cdn-icons-png.flaticon.com/512/2838/2838912.png',
                      height: 16.sp,
                      width: 16.sp,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Travel',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Action Menu here, make it look exactly like the on in the image. give it another backdrop, and then the out curved border radius on the top right and bottom right
        // Replace the existing Action Menu section with this:
        Positioned(
          right: 0,
          top: 0.h,
          bottom: 0,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.r),
                bottomLeft: Radius.circular(32.r),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: 57.w,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.r),
                      bottomLeft: Radius.circular(32.r),
                    ),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      actionMenuIcon('assets/svgs/thumbs.svg'),
                      SizedBox(height: 10.h),
                      actionMenuIcon('assets/svgs/messages-filled.svg'),
                      SizedBox(height: 10.h),
                      actionMenuIcon('assets/svgs/more_horiz.svg'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        // Bottom Content
        Positioned(
          bottom: 16.h,
          left: 16.w,
          right: 16.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 250.w,
                child: Text(
                  'If you could live anywhere in the world, where would you pick?',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 2,
                      ),
                      image: const DecorationImage(
                        image: NetworkImage('https://picsum.photos/200'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Miranda Kehlani',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'STUTTGART',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget actionMenuIcon(String icon) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(50),
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: SvgPicture.asset(
        icon,
        height: 17.sp,
        width: 17.sp,
        color: Colors.white,
        fit: BoxFit.cover,
      ),
    ),
  );
}
