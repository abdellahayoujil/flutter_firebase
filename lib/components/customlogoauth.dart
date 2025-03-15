import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class CustomLogoAuth extends StatelessWidget {
  const CustomLogoAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: 120.w,
        height: 120.h,
        padding: EdgeInsets.all(1.w),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(70.r),
        ),
        child: Lottie.asset(
          "images/notelottie.json",
          width: 100.w,
        ),
      ),
    );
  }
}