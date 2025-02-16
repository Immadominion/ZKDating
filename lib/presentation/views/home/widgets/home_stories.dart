import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget homeStorySection() {
  return SizedBox(
    height: 100.h, // Responsive height
    child: ListView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      children: [
        myStory(),
        ...List.generate(
          images.length,
          (index) => othersStories(
            name: ['Selena', 'Clara', 'Fabian', 'Ge'][index % 4],
            image: images[index],
            isViewed: index >= 3,
          ),
        ),
      ],
    ),
  );
}

Widget myStory() {
  return Container(
    margin: EdgeInsets.only(right: 16.w),
    child: Column(
      children: [
        Stack(
          children: [
            Container(
              width: 65.w,
              height: 65.w, // Maintain aspect ratio
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/pp1.png',
                  width: 65.w,
                  height: 65.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 2.h,
              right: 2.w,
              child: Container(
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2.r,
                  ),
                ),
                child: Icon(
                  Icons.add,
                  size: 14.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          'My Story',
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}

Widget othersStories(
    {required String name, required bool isViewed, required String image}) {
  return Container(
    margin: EdgeInsets.only(right: 16.w),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(2.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: isViewed
                ? null
                : const LinearGradient(
                    colors: [Colors.purple, Colors.pink],
                  ),
          ),
          child: Container(
            padding: EdgeInsets.all(2.r),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.asset(
                image,
                width: 60.w,
                height: 60.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          name,
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}

List<String> images = [
  'assets/images/pp2.png',
  'assets/images/pp1.png',
  'assets/images/pp3.png',
  'assets/images/pp4.png',
];
