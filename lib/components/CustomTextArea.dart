// ignore_for_file: file_names

import 'package:firebase_flutter/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextArea extends StatefulWidget {
  final String hinttext;
  final TextEditingController mycontroller;
  final String? Function(String?)? validator;

  const CustomTextArea({
    super.key,
    required this.hinttext,
    required this.mycontroller,
    required this.validator,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextAreaState createState() => _CustomTextAreaState();
}

class _CustomTextAreaState extends State<CustomTextArea> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h, 
      child: TextFormField(
        style: TextStyle(fontSize: 17.sp),
        validator: widget.validator,
        controller: widget.mycontroller,
        keyboardType: TextInputType.multiline,
        maxLines: null, 
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        cursorColor: MyColors.myYellowgrey, 
        decoration: InputDecoration(
          hintText: widget.hinttext,
          hintStyle: TextStyle(fontSize: 14.sp, color: MyColors.mygrey),
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
      ),
    );
  }
}
