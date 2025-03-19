import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/Categoris/update.dart';
import 'package:firebase_flutter/components/customlogoauth.dart';
import 'package:firebase_flutter/constans.dart';
import 'package:firebase_flutter/note/viewnote.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<QueryDocumentSnapshot> data = [];
  bool isLoading = true;
  User? user = FirebaseAuth.instance.currentUser;
  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categoris')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    data.addAll(querySnapshot.docs);
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 180.h,
              child: UserAccountsDrawerHeader(
                accountName: const Text("Welcome!",
                    style: TextStyle(fontSize: 20, color: MyColors.myWhite)),
                accountEmail: Text(user?.email ?? "No Email Found",
                    style: TextStyle(fontSize: 18.sp, color: MyColors.myWhite)),
                currentAccountPicture: const CustomLogoAuth(),
                decoration: const BoxDecoration(
                  color: MyColors.myYellow,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, size: 25.sp, color: MyColors.myblack),
              title: Text("Accueil", style: TextStyle(fontSize: 18.sp)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications,
                  size: 25.sp, color: MyColors.myblack),
              title: Text("Notification", style: TextStyle(fontSize: 18.sp)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, size: 25.sp, color: MyColors.myblack),
              title: Text("Logout", style: TextStyle(fontSize: 18.sp)),
              onTap: () async {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.rightSlide,
                  title: 'Confirm Action',
                  desc: 'Are you sure you want to log out?',
                  btnCancelText: "Cancel",
                  btnOkText: "Logout",
                  btnCancelOnPress: () {},
                  btnOkOnPress: () async {
                    GoogleSignIn googleSignIn = GoogleSignIn();
                    googleSignIn.disconnect();
                    await FirebaseAuth.instance.signOut();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("login", (route) => false);
                  },
                ).show();
              },
            ),
            ListTile(
              leading: Icon(Icons.info, size: 25.sp, color: MyColors.myblack),
              title: Text("About", style: TextStyle(fontSize: 18.sp)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.myYellow,
        onPressed: () {
          Navigator.of(context).pushNamed("addcategory");
        },
        child: Icon(Icons.add, size: 30.sp),
      ),
      appBar: AppBar(
        title: Text('Home Page', style: TextStyle(fontSize: 22.sp)),
        backgroundColor: MyColors.myYellow,
        /*actions: [
          IconButton(
            onPressed: () async {
              GoogleSignIn googleSignIn = GoogleSignIn();
              googleSignIn.disconnect();
              await FirebaseAuth.instance.signOut();
              // ignore: use_build_context_synchronously
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
            },
            icon: Icon(Icons.logout, size: 25.sp),
          ),
        ],*/
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(12.w),
              child: GridView.builder(
                itemCount: data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 16.w,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            Viewpage(categoryId: data[index].id),
                      ));
                    },
                    onLongPress: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.rightSlide,
                        title: 'Options',
                        desc: 'What do you want to do?',
                        btnCancelText: "Delete",
                        btnOkText: "Update",
                        btnCancelOnPress: () async {
                          await FirebaseFirestore.instance
                              .collection('categoris')
                              .doc(data[index].id)
                              .delete();
                          // ignore: use_build_context_synchronously
                          Navigator.of(context)
                              .pushReplacementNamed("homepage");
                        },
                        btnOkOnPress: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Updatecategoris(
                              docid: data[index].id,
                              oldname: data[index]['name'],
                            ),
                          ));
                        },
                      ).show();
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      elevation: 8,
                      // ignore: deprecated_member_use
                      shadowColor: MyColors.myblack.withOpacity(0.1),
                      color: MyColors.myWhite,
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          gradient: const LinearGradient(
                            colors: [
                              MyColors.myWhite,
                              MyColors.myYellow,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "images/fl.png",
                              height: 100.h,
                              width: 100.w,
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "${data[index]['name']}",
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: MyColors.myWhite,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
