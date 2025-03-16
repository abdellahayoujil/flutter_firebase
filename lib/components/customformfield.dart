import 'package:firebase_flutter/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomformfieldAdd extends StatelessWidget {
  final String hinttext;
  final TextEditingController mycontroller;
  final String? Function(String?)? validator;

  const CustomformfieldAdd({
    super.key,
    required this.hinttext,
    required this.mycontroller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: mycontroller,
      style: TextStyle(fontSize: 14.sp),
      cursorColor: MyColors.myYellowgrey, 
        decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 20.w,
          ),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: const BorderSide(color: MyColors.myYellowgrey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: const BorderSide(color: MyColors.myYellowgrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: const BorderSide(color: MyColors.myYellowgrey, width: 2),
          ),
        ),
    );
  }
}