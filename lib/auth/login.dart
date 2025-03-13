import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/constans.dart';
import 'package:flutter/material.dart';
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

    if (googleUser == null) {
      return;
    }

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushNamedAndRemoveUntil("homepage", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(20),
              child: ListView(children: [
                Form(
                  key: formstate,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 50),
                      const CustomLogoAuth(),
                      Container(height: 20),
                      const Text("Login",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: MyColors.myblack)),
                      Container(height: 10),
                      const Text("Login To Continue Using The App",
                          style: TextStyle(color: Colors.grey)),
                      Container(height: 20),
                      const Text(
                        "Email",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: MyColors.myblack),
                      ),
                      Container(height: 10),
                      CustomTextForm(
                        hinttext: "ُEnter Your Email",
                        mycontroller: email,
                        validator: (val) {
                          if (val == "") {
                            return "label is empty";
                          }
                          return null;
                        },
                      ),
                      Container(height: 10),
                      const Text(
                        "Password",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: MyColors.myblack),
                      ),
                      Container(height: 10),
                      CustomTextForm(
                        hinttext: "ُEnter Your Password",
                        mycontroller: password,
                        validator: (val) {
                          if (val == "") {
                            return "label is empty";
                          }
                          return null;
                        },
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
                    ],
                  ),
                ),
                CustomButtonAuth(
                  title: "login",
                  onPressed: () async {
                    if (formstate.currentState!.validate()) {
                      try {
                        isLoading = true;
                        setState(() {});
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: email.text, password: password.text);
                        isLoading = false;
                        setState(() {});
                        if (credential.user!.emailVerified) {
                          // ignore: use_build_context_synchronously
                          Navigator.of(context)
                              .pushReplacementNamed("homepage");
                        } else {
                          FirebaseAuth.instance.currentUser!
                              .sendEmailVerification();
                          AwesomeDialog(
                            // ignore: use_build_context_synchronously
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'verify your email please.',
                          ).show();
                          isLoading = false;
                        setState(() {});
                        }
                      } on FirebaseAuthException catch (e) {
                        isLoading = false;
                        setState(() {});
                        if (e.code == 'user-not-found') {
                          // ignore: avoid_print
                          print('No user found for that email: ${e.message}');
                          AwesomeDialog(
                            // ignore: use_build_context_synchronously
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'No user found for that email.',
                          ).show();
                        } else if (e.code == 'wrong-password') {
                          // ignore: avoid_print
                          print('Wrong password: ${e.message}');
                          AwesomeDialog(
                            // ignore: use_build_context_synchronously
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'Wrong password provided.',
                          ).show();
                        } else {
                          // ignore: avoid_print
                          print('Other error: ${e.code} - ${e.message}');
                          AwesomeDialog(
                            // ignore: use_build_context_synchronously
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'Login failed: ${e.message}',
                          ).show();
                        }
                      } catch (e) {
                        // ignore: avoid_print
                        print('General error: $e');
                        AwesomeDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'An unexpected error occurred.',
                        ).show();
                      }
                    } else {
                      // ignore: avoid_print
                      print("not valid");
                    }
                  },
                ),
                Container(height: 20),
                MaterialButton(
                    height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: MyColors.myred,
                    textColor: MyColors.myWhite,
                    onPressed: () {
                      signInWithGoogle();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Login With Google  "),
                        Image.asset(
                          "images/4.png",
                          width: 20,
                        )
                      ],
                    )),
                Container(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed("signup");
                  },
                  child: const Center(
                    child: Text.rich(TextSpan(children: [
                      TextSpan(
                          text: "Don't Have An Account ? ",
                          style: TextStyle(color: MyColors.myblack)),
                      TextSpan(
                          text: "Register",
                          style: TextStyle(
                              color: MyColors.myYellow,
                              fontWeight: FontWeight.bold)),
                    ])),
                  ),
                )
              ]),
            ),
    );
  }
}
