// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Firebase Install'),
          actions: [
            IconButton(onPressed: () async{
              GoogleSignIn googleSignIn = GoogleSignIn();
              googleSignIn.disconnect();
              await FirebaseAuth.instance.signOut();
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);
            }, 
            icon: const Icon(Icons.logout))
          ],
        ),
        body: ListView(
          children: [
            FirebaseAuth.instance.currentUser!.emailVerified
            ? const Text("succesfuly verifed")
            : MaterialButton(
              textColor: Colors.white,
              color: Colors.red,
              onPressed: (){
                FirebaseAuth.instance.currentUser!.sendEmailVerification();
            },child: const Text("please verifed Email"),)
          ],
        ));
  }
}
