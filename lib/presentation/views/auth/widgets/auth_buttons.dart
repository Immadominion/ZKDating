import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final String iconPath;
  final Color buttonColor;
  final Color textColor;
  final bool isIconSvg;

  const CustomElevatedButton({
    Key? key,
    required this.onPressed,
    this.text = "",
    required this.iconPath,
    this.buttonColor = const Color(0xFF4B164C),
    this.textColor = Colors.white,
    this.isIconSvg = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: text == "" ? 50.h : 300.w,
      height: 56.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(32.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.zero,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              isIconSvg
                  ? SvgPicture.asset(
                      iconPath,
                      height: 40.h,
                      width: 40.h,
                    )
                  : Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.r),
                        child: SizedBox(
                          height: 40.h,
                          width: 40.h,
                          child: Image.asset(
                            iconPath,
                            height: 40.h,
                            width: 40.h,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
              Expanded(
                child: text == ""
                    ? const SizedBox()
                    : Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 15.sp,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
