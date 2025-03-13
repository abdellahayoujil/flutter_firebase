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
              CustomButtonAuth(title: "Add", onPressed: () {
                
              },)
            ],
          )),
    );
  }
}
