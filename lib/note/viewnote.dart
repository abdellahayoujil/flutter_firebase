import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/constans.dart';
import 'package:firebase_flutter/note/addnote.dart';
import 'package:firebase_flutter/note/editnote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Viewpage extends StatefulWidget {
  final String categoryId;
  const Viewpage({super.key, required this.categoryId});

  @override
  State<Viewpage> createState() => _ViewpageState();
}

class _ViewpageState extends State<Viewpage> {
  List<QueryDocumentSnapshot> data = [];
  bool isLoading = true;

  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categoris')
        .doc(widget.categoryId)
        .collection("note")
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
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Addnote(docId: widget.categoryId)));
        },
        child: Icon(Icons.add, size: 28.sp), 
      ),
      appBar: AppBar(
        title: Text(
          'Notes',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
       /* actions: [
          IconButton(
            icon: Icon(Icons.logout, size: 24.sp),
            onPressed: () async {
              GoogleSignIn googleSignIn = GoogleSignIn();
              googleSignIn.disconnect();
              await FirebaseAuth.instance.signOut();
              // ignore: use_build_context_synchronously
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
            },
          ),
        ],*/
      ),
      // ignore: deprecated_member_use
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("homepage", (route) => false);
          return false;
        },
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                    color: MyColors.myYellow))
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: GridView.builder(
                  itemCount: data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                    mainAxisExtent: 160.h,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onLongPress: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.rightSlide,
                          title: 'Delete',
                          desc: 'Are you sure you want to delete this note?',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () async {
                            await FirebaseFirestore.instance
                                .collection('categoris')
                                .doc(widget.categoryId)
                                .collection("note")
                                .doc(data[index].id)
                                .delete();
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    Viewpage(categoryId: widget.categoryId)));
                          },
                        ).show();
                      },
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Editnote(
                                notedocId: data[index].id,
                                categorydocId: widget.categoryId,
                                oldnote: data[index]['note'])));
                      },
                      child: Card(
                        elevation: 5, 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data[index]['note']}",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: MyColors.myblack,
                                ),
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Icon(Icons.edit,
                                    size: 20.sp, color: MyColors.myYellow),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
