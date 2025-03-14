import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/components/custombuttonauth.dart';
import 'package:firebase_flutter/components/customformfield.dart';
import 'package:firebase_flutter/note/viewnote.dart';
import 'package:flutter/material.dart';

class Editnote extends StatefulWidget {
  final String notedocId;
  final String categorydocId;
  final String oldnote;
  const Editnote({super.key, required this.notedocId, required this.categorydocId, required this.oldnote});

  @override
  State<Editnote> createState() => _EditnoteState();
}

class _EditnoteState extends State<Editnote> {
  TextEditingController note = TextEditingController();

  bool isLoading = false;

  Future<void> editnote() async {
    CollectionReference collectionnote = FirebaseFirestore.instance
        .collection('categoris')
        .doc(widget.categorydocId)
        .collection("note");
    if (formstate.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {});
        // ignore: unused_local_variable
        await collectionnote.doc(widget.notedocId).update({'note': note.text});
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => Viewpage(categoryId: widget.categorydocId)));
      } catch (e) {
        isLoading = false;
        setState(() {});
        // ignore: avoid_print
        print("error ================= $e");
      }
    }
  }

  @override
  void initState() {
    note.text = widget.oldnote;
    super.initState();
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
      appBar: AppBar(title: const Text("Edit Note")),
      body: Form(
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
                      child: CustomformfieldAdd(
                          hinttext: "Enter your note",
                          mycontroller: note,
                          validator: (val) {
                            if (val == "") {
                              return "can't to be empty";
                            }
                            return null;
                          }),
                    ),
                    CustomButtonAuth(
                      title: "save",
                      onPressed: () {
                        editnote();
                      },
                    )
                  ],
                )),
    );
  }
}
