import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_database/components/app_button.dart';
import 'package:student_database/components/app_text.dart';
import '../components/error_dailogbox.dart';
import '../components/loading_bar.dart';
import 'homepage.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  clearText() {
    nameController.clear();
    emailController.clear();
  }

  Future addData() async {
    if (nameController.text.isNotEmpty && emailController.text.isNotEmpty) {
      showDialog(
        context: context,
        builder: (e) {
          return const LoadingDialogBox(
            message: "Registrating doing",
          );
        },
      );
      users.add({
        "UserUID": nameController.text.trim(),
        "UserEmail": emailController.text.trim(),
      }).then((value) {
        Navigator.pop(context);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MyHomePage()));
        showDialog(
            context: context,
            builder: (c) => ErrorDialogBox(
                  message: value.toString(),
                ));
      }).catchError((error) => print("Failed to add user: $error"));
    } else {
      showDialog(
        context: context,
        builder: (e) {
          return const ErrorDialogBox(
              message: "Please enter all mandatory fields");
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const UbuntuTextStyle(
          textData: "Add Data",
          fontSize: 20,
          fontStyle: FontStyle.normal,
          maxLines: 1,
          textAlign: TextAlign.left,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: "Name",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: "Email",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppButton(
                      text: "Register",
                      borderRadius: 5,
                      bgColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      onTap: () {
                        addData();
                        clearText();
                      }),
                  AppButton(
                      text: "Reset",
                      borderRadius: 5,
                      bgColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      onTap: () => clearText())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
