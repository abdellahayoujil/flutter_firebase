import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/components/custombuttonauth.dart';
import 'package:firebase_flutter/components/customformfield.dart';
import 'package:flutter/material.dart';

class Updatecategoris extends StatefulWidget {
  final String docid;
  final String oldname;
  const Updatecategoris({super.key, required this.docid, required this.oldname});

  @override
  State<Updatecategoris> createState() => _UpdatecategorisState();
}

class _UpdatecategorisState extends State<Updatecategoris> {
  TextEditingController name = TextEditingController();


  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  CollectionReference categoris =
      FirebaseFirestore.instance.collection('categoris');

  bool isLoading = false;

  // ignore: non_constant_identifier_names
  Updatecategoris() async {
    if (formstate.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {
        });
        // ignore: unused_local_variable
        await categoris.doc(widget.docid).update({
          "name" : name.text
        });
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushNamedAndRemoveUntil("homepage", (route) => false);
      } catch (e) {
        isLoading = false;
        setState(() {
        });
        // ignore: avoid_print
        print("error ================= $e");
      }
    }
  }
  @override
  void initState() {
    super.initState();
    name.text = widget.oldname;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Category")),
      body: Form(
          key: formstate,
          child: isLoading ? const Center(child: CircularProgressIndicator(),) : Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: CustomformfieldAdd(
                    hinttext: "Enter name of category",
                    mycontroller: name,
                    validator: (val) {
                      if (val == "") {
                        return "can't to be empty";
                      }
                      return null;
                    }),
              ),
              CustomButtonAuth(
                title: "Add",
                onPressed: () {
                  Updatecategoris();
                },
              )
            ],
          )),
    );
  }
}
