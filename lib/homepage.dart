import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/Categoris/update.dart';
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.myYellow,
        onPressed: () {
          Navigator.of(context).pushNamed("addcategory");
        },
        child: Icon(Icons.add, size: 30.sp),
      ),
      appBar: AppBar(
        title: Text('Firebase Install', style: TextStyle(fontSize: 22.sp)),
        backgroundColor: MyColors.myYellow,
        actions: [
          IconButton(
            onPressed: () async {
              GoogleSignIn googleSignIn = GoogleSignIn();
              googleSignIn.disconnect();
              await FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
            },
            icon: Icon(Icons.logout, size: 25.sp),
          ),
        ],
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
                      shadowColor: Colors.black.withOpacity(0.1),
                      color: Colors.white,
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade50,
                              Colors.blue.shade100,
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
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade900,
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
