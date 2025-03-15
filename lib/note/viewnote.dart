// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/constans.dart';
import 'package:firebase_flutter/note/addnote.dart';
import 'package:firebase_flutter/note/editnote.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('home'),
          actions: [
            IconButton(
                onPressed: () async {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  googleSignIn.disconnect();
                  await FirebaseAuth.instance.signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("login", (route) => false);
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        // ignore: deprecated_member_use
        body: WillPopScope(
            child: isLoading
                ? const Center(child: Text("Loading ..."))
                : GridView.builder(
                    itemCount: data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisExtent: 160),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onLongPress: () {
                          AwesomeDialog(
                              // ignore: use_build_context_synchronously
                              context: context,
                              dialogType: DialogType.warning,
                              animType: AnimType.rightSlide,
                              title: 'delete',
                              desc: 'are you sure to delete this note! ',
                              btnCancelOnPress: () async {},
                              btnOkOnPress: () async {
                                await FirebaseFirestore.instance
                                    .collection('categoris')
                                    .doc(widget.categoryId)
                                    .collection("note")
                                    .doc(data[index].id)
                                    .delete();
                                // ignore: use_build_context_synchronously
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) => Viewpage(categoryId: widget.categoryId)));
                              }).show();
                        },
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Editnote(
                                  notedocId: data[index].id,
                                  categorydocId: widget.categoryId,
                                  oldnote: data[index]['note'])));
                        },
                        child: Card(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [Text("${data[index]['note']}")],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
            onWillPop: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("homepage", (route) => false);
              return Future.value(false);
            }));
  }
}
