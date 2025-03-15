import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/components/custombuttonauth.dart';
import 'package:firebase_flutter/components/customlogoauth.dart';
import 'package:firebase_flutter/components/textformfield.dart';
import 'package:firebase_flutter/constans.dart';
import 'package:flutter/material.dart';

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
                const Text("SignUp",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: MyColors.myblack)),
                Container(height: 10),
                const Text("SignUp To Continue Using The App",
                    style: TextStyle(color: Colors.grey)),
                Container(height: 20),
                const Text(
                  "username",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: MyColors.myblack),
                ),
                Container(height: 10),
                CustomTextForm(
                  hinttext: "ُEnter Your username",
                  mycontroller: username,
                  validator: (val) {
                    if (val == "") {
                      return "label is empty";
                    }
                    return null;
                  },
                ),
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
                  inputType: TextInputType.emailAddress,
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
                  isPassword: true,
                ),
              ],
            ),
          ),
           Container(height: 30),
          CustomButtonAuth(
              title: "SignUp",
              onPressed: () async {
                if (formstate.currentState!.validate()) {
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    );
                    FirebaseAuth.instance.currentUser!.sendEmailVerification();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacementNamed("login");
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      // ignore: avoid_print
                      print('The password provided is too weak.');
                      AwesomeDialog(
                        // ignore: use_build_context_synchronously
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc: 'The password provided is too weak.',
                      ).show();
                    } else if (e.code == 'email-already-in-use') {
                      // ignore: avoid_print
                      print('The account already exists for that email.');
                      AwesomeDialog(
                        // ignore: use_build_context_synchronously
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc: 'The account already exists for that email.',
                      ).show();
                    }
                  } catch (e) {
                    // ignore: avoid_print
                    print(e);
                  }
                }
              }),
          Container(height: 20),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed("login");
            },
            child: const Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                    text: "Have An Account ? ",
                    style: TextStyle(color: MyColors.myblack)),
                TextSpan(
                    text: "Login",
                    style: TextStyle(
                        color: MyColors.myYellow, fontWeight: FontWeight.bold)),
              ])),
            ),
          )
        ]),
      ),
    );
  }
}
