import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/components/custombuttonauth.dart';
import 'package:firebase_flutter/components/customlogoauth.dart';
import 'package:firebase_flutter/components/textformfield.dart';
import 'package:firebase_flutter/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 254, 224, 134), MyColors.myYellow],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomLogoAuth(),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.r,
                          spreadRadius: 2.r,
                        )
                      ],
                    ),
                    child: Form(
                      key: formstate,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text("SignUp",
                                style: TextStyle(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.myblack)),
                          ),
                          SizedBox(height: 10.h),
                          Center(
                            child: Text("SignUp To Continue Using The App",
                                style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
                          ),
                          SizedBox(height: 20.h),
                          Text("Username",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                  color: MyColors.myblack)),
                          SizedBox(height: 10.h),
                          CustomTextForm(
                            hinttext: "Enter Your Username",
                            mycontroller: username,
                            validator: (val) {
                              if (val == "") {
                                return "Username cannot be empty";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20.h),
                          Text("Email",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                  color: MyColors.myblack)),
                          SizedBox(height: 10.h),
                          CustomTextForm(
                            hinttext: "Enter Your Email",
                            mycontroller: email,
                            validator: (val) {
                              if (val == "") {
                                return "Email cannot be empty";
                              }
                              return null;
                            },
                            inputType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 20.h),
                          Text("Password",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                  color: MyColors.myblack)),
                          SizedBox(height: 10.h),
                          CustomTextForm(
                            hinttext: "Enter Your Password",
                            mycontroller: password,
                            validator: (val) {
                              if (val == "") {
                                return "Password cannot be empty";
                              }
                              return null;
                            },
                            isPassword: true,
                          ),
                          SizedBox(height: 30.h),
                          CustomButtonAuth(
                            title: "Sign Up",
                            onPressed: () async {
                              if (formstate.currentState!.validate()) {
                                try {
                                  final credential = await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                    email: email.text,
                                    password: password.text,
                                  );
                                  FirebaseAuth.instance.currentUser!.sendEmailVerification();
                                  Navigator.of(context).pushReplacementNamed("login");
                                } on FirebaseAuthException catch (e) {
                                  String errorMessage;
                                  if (e.code == 'weak-password') {
                                    errorMessage = 'The password provided is too weak.';
                                  } else if (e.code == 'email-already-in-use') {
                                    errorMessage = 'The account already exists for that email.';
                                  } else {
                                    errorMessage = 'An unexpected error occurred: ${e.message}';
                                  }
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    title: 'Error',
                                    desc: errorMessage,
                                  ).show();
                                }
                              }
                            },
                          ),
                          SizedBox(height: 20.h),
                          Center(
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed("login");
                              },
                              child: Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                      text: "Have An Account? ",
                                      style: TextStyle(
                                          color: MyColors.myblack, fontSize: 14.sp)),
                                  TextSpan(
                                      text: "Login",
                                      style: TextStyle(
                                          color: MyColors.myYellow,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp)),
                                ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
