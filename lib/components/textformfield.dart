import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextForm extends StatelessWidget {
  final String hinttext ; 
  final TextEditingController mycontroller ; 
  final String? Function(String?)? validator;
  const CustomTextForm({super.key, required this.hinttext, required this.mycontroller, required this.validator});

   @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 14.sp),
      validator: validator,
      controller: mycontroller,
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
          borderRadius: BorderRadius.circular(50.r),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.r),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
