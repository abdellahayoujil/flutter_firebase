import 'package:firebase_flutter/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonAuth extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  const CustomButtonAuth({super.key, this.onPressed, required this.title});

 @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 30.h,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      color: MyColors.myYellow,
      textColor: Colors.white,
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(fontSize: 16.sp),
      ),
    );
  }
}
