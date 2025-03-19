import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/components/CustomTextArea.dart';
import 'package:firebase_flutter/components/custombuttonadd.dart';
import 'package:firebase_flutter/note/viewnote.dart';
import 'package:flutter/material.dart';

class Addnote extends StatefulWidget {
  final String docId;
  const Addnote({super.key, required this.docId});

  @override
  State<Addnote> createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> {
  TextEditingController note = TextEditingController();

  bool isLoading = false;

  Future<void> addNote() async {
    CollectionReference collectionnote = FirebaseFirestore.instance
        .collection('categoris')
        .doc(widget.docId)
        .collection("note");
    if (formstate.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {});
        // ignore: unused_local_variable
        DocumentReference res = await collectionnote.add({'note': note.text});
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => Viewpage(categoryId: widget.docId)));
      } catch (e) {
        isLoading = false;
        setState(() {});
        // ignore: avoid_print
        print("error ================= $e");
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    note.dispose();
  }

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Note")),
      body: SingleChildScrollView(
        child: Form(
            key: formstate,
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 25),
                        child: CustomTextArea(
                            hinttext: "Enter your note",
                            mycontroller: note,
                            validator: (val) {
                              if (val == "") {
                                return "can't to be empty";
                              }
                              return null;
                            }),
                      ),
                      CustomButtonadd(
                        title: "Add",
                        onPressed: () {
                          addNote();
                        },
                      )
                    ],
                  )),
      ),
    );
  }
}
