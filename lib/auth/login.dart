import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../components/custombuttonauth.dart';
import '../components/customlogoauth.dart';
import '../components/textformfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  bool isLoading = false;

  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return;

    final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil("homepage", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [MyColors.myYellow, MyColors.myred],
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
                        const CustomLogoAuth(),
                        SizedBox(height: 20.h),
                        Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: MyColors.myWhite,
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                color: MyColors.myblacklight,
                                blurRadius: 10.r,
                                spreadRadius: 2.r,
                              ),
                            ],
                          ),
                          child: Form(
                            key: formstate,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text("Login",
                                      style: TextStyle(
                                          fontSize: 30.sp,
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.myblack)),
                                ),
                                SizedBox(height: 10.h),
                                Center(
                                  child: Text("Login To Continue Using The App",
                                      style: TextStyle(color: MyColors.mygrey, fontSize: 14.sp)),
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
                                  validator: (val) =>
                                      val!.isEmpty ? "Email is required" : null,
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
                                  validator: (val) =>
                                      val!.isEmpty ? "Password is required" : null,
                                  isPassword: true,
                                ),
                                 Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 20),
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () async {
                            if (email.text == "") {
                              AwesomeDialog(
                                // ignore: use_build_context_synchronously
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Error',
                                desc: 'enter your email please.',
                              ).show();
                              return;
                            }
                            try {
                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(email: email.text);
                              AwesomeDialog(
                                // ignore: use_build_context_synchronously
                                context: context,
                                dialogType: DialogType.info,
                                animType: AnimType.rightSlide,
                                title: 'info',
                                desc:
                                    'verify your email we send message to update your password.',
                              ).show();
                            } catch (e) {
                              AwesomeDialog(
                                // ignore: use_build_context_synchronously
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Error',
                                desc: 'No user found for that email. $e',
                              ).show();
                            }
                          },
                          child: const Text(
                            "Forgot Password ?",
                            style: TextStyle(
                                fontSize: 14, color: MyColors.myblack),
                          ),
                        ),
                      ),
                                CustomButtonAuth(
                                  title: "Login",
                                  onPressed: () async {
                                    if (formstate.currentState!.validate()) {
                                      try {
                                        setState(() => isLoading = true);
                                        final credential = await FirebaseAuth.instance
                                            .signInWithEmailAndPassword(
                                                email: email.text, password: password.text);

                                        if (!credential.user!.emailVerified) {
                                          await credential.user!.sendEmailVerification();
                                          if (!mounted) return;
                                          AwesomeDialog(
                                            // ignore: use_build_context_synchronously
                                            context: context,
                                            dialogType: DialogType.info,
                                            animType: AnimType.rightSlide,
                                            title: 'Verify Email',
                                            desc: 'A verification link has been sent to your email',
                                          ).show();
                                        } else {
                                          if (!mounted) return;
                                          // ignore: use_build_context_synchronously
                                          Navigator.pushReplacementNamed(context, "homepage");
                                        }
                                      } on FirebaseAuthException catch (e) {
                                        String message = 'Login failed';
                                        if (e.code == 'user-not-found') {
                                          message = 'No user found for this email';
                                        } else if (e.code == 'wrong-password') {
                                          message = 'Incorrect password';
                                        }
                                        AwesomeDialog(
                                          // ignore: use_build_context_synchronously
                                          context: context,
                                          dialogType: DialogType.error,
                                          animType: AnimType.rightSlide,
                                          title: 'Error',
                                          desc: message,
                                        ).show();
                                      } finally {
                                        if (mounted) setState(() => isLoading = false);
                                      }
                                    }
                                  },
                                ),
                                SizedBox(height: 20.h),
                                MaterialButton(
                                  height: 40.h,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.r)),
                                  color: MyColors.myred,
                                  textColor: MyColors.myWhite,
                                  onPressed: signInWithGoogle,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Login With Google  ", style: TextStyle(fontSize: 14.sp)),
                                      Image.asset("images/4.png", width: 20.w)
                                    ],
                                  ),
                                ),
                                SizedBox(height: 30.h),
                                Center(
                                  child: InkWell(
                                    onTap: () => Navigator.pushReplacementNamed(context, "signup"),
                                    child: Text.rich(
                                      TextSpan(children: [
                                        TextSpan(
                                            text: "Don't Have An Account? ",
                                            style: TextStyle(
                                                color: MyColors.myblack, fontSize: 14.sp)),
                                        TextSpan(
                                            text: "Register",
                                            style: TextStyle(
                                                color: MyColors.myYellow,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.sp)),
                                      ]),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30.h),
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
