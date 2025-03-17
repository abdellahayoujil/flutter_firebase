// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/components/custombuttonadd.dart';
import 'package:firebase_flutter/components/customformfield.dart';
import 'package:flutter/material.dart';

class Addcategoris extends StatefulWidget {
  const Addcategoris({super.key});

  @override
  State<Addcategoris> createState() => _AddcategorisState();
}

class _AddcategorisState extends State<Addcategoris> {
  TextEditingController name = TextEditingController();

  CollectionReference categoris =
      FirebaseFirestore.instance.collection('categoris');

  bool isLoading = false;

  Future<void> addcategoris() async {
    if (formstate.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {
        });
        // ignore: unused_local_variable
        DocumentReference res = await categoris.add(
            {'name': name.text, 'id': FirebaseAuth.instance.currentUser!.uid});
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
  void dispose() {
    super.dispose();
    name.dispose();
  }
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
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
              CustomButtonadd(
                title: "Add",
                onPressed: () {
                  addcategoris();
                },
              )
            ],
          )),
    );
  }
}
