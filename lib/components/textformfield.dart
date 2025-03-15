import 'package:firebase_flutter/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextForm extends StatefulWidget {
  final String hinttext;
  final TextEditingController mycontroller;
  final String? Function(String?)? validator;
  final TextInputType inputType;
  final bool isPassword;

  const CustomTextForm({
    super.key,
    required this.hinttext,
    required this.mycontroller,
    required this.validator,
    this.inputType = TextInputType.text,
    this.isPassword = false,
  });

  @override
  _CustomTextFormState createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  bool _obscureText = true; 

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 14.sp),
      validator: widget.validator,
      controller: widget.mycontroller,
      keyboardType: widget.inputType,
      obscureText: widget.isPassword ? _obscureText : false,
      cursorColor: MyColors.myYellowgrey, 
      selectionControls: MaterialTextSelectionControls(), 
      decoration: InputDecoration(
        hintText: widget.hinttext,
        hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 20.w,
        ),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.r),
          borderSide: const BorderSide(color: MyColors.myYellowgrey), 
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.r),
          borderSide: const BorderSide(color: MyColors.myYellowgrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.r),
          borderSide: const BorderSide(color: MyColors.myYellowgrey, width: 2), 
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
