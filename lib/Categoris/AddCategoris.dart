import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/components/custombuttonauth.dart';
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

  Future<void> addcategoris() async {
    if (formstate.currentState!.validate()) {
      try {
        DocumentReference res = await categoris.add({
          'name': name.text,
        });
        Navigator.of(context).pushReplacementNamed("homepage");
      } catch (e) {
        print("error ================= $e");
      }
    }
  }

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Category")),
      body: Form(
          key: formstate,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
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
                  addcategoris();
                },
              )
            ],
          )),
    );
  }
}
