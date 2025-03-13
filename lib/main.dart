import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutter/Categoris/AddCategoris.dart';
import 'package:firebase_flutter/constans.dart';
import 'package:firebase_flutter/homepage.dart';
import 'auth/login.dart';
import 'auth/signup.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // ignore: avoid_print
        print('-----------------------------User is currently signed out!');
      } else {
        // ignore: avoid_print
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: MyColors.myYellow,
              titleTextStyle: TextStyle(
                  color: MyColors.myWhite,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
              iconTheme: IconThemeData(color: MyColors.myWhite))),
      debugShowCheckedModeBanner: false,
      home: (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? const Homepage()
          : const Login(),
      routes: {
        "signup": (context) => const SignUp(),
        "login": (context) => const Login(),
        "homepage": (context) => const Homepage(),
        "addcategory": (context) => const Addcategoris(),
      },
    );
  }
}
