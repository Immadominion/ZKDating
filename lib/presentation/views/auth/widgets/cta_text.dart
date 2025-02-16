import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CTAText extends StatelessWidget {
  final VoidCallback onTap;

  const CTAText({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Don\'t have an account? ',
        style: TextStyle(
          color: Colors.black,
          fontSize: 15.sp,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Sign Up',
            style: TextStyle(
              color: const Color(0xFFDD88CF),
              decoration: TextDecoration.underline,
              fontSize: 14.sp,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
