import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutter/Categoris/AddCategoris.dart';
import 'package:firebase_flutter/constans.dart';
import 'package:firebase_flutter/homepage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), // Default design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: MyColors.myYellow,
              titleTextStyle: TextStyle(
                color: MyColors.myWhite,
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
              ),
              iconTheme: const IconThemeData(color: MyColors.myWhite),
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: child,
          routes: {
            "signup": (context) => const SignUp(),
            "login": (context) => const Login(),
            "homepage": (context) => const Homepage(),
            "addcategory": (context) => const Addcategoris(),
          },
        );
      },
      child: (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? const Homepage()
          : const Login(),
    );
  }
}
