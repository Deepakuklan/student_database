import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_database/pages/homepage.dart';

import '../components/app_button.dart';
import '../components/app_text.dart';

class UpdateData extends StatefulWidget {
  final String dataId;

  const UpdateData({Key? key, required this.dataId}) : super(key: key);

  @override
  _UpdateDataState createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  final _formKey = GlobalKey<FormState>();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> update(dataId, name, email) {
    return users
        .doc(dataId)
        .update({'UserEmail': email, 'UserUID': name})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const UbuntuTextStyle(
          textData: "update Data",
          fontSize: 20,
          fontStyle: FontStyle.normal,
          maxLines: 1,
          textAlign: TextAlign.left,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(widget.dataId)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return const Text("Document does not exist");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            var name = data["UserUID"] ?? "";
            var email = data["UserEmail"] ?? "";

            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) => name = value,
                      initialValue: name,
                      decoration: const InputDecoration(
                        hintText: "Name",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (value) => email = value,
                      initialValue: email,
                      decoration: const InputDecoration(
                        hintText: "Email",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AppButton(
                          text: "Update",
                          borderRadius: 5,
                          bgColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          onTap: () {
                            update(widget.dataId, name, email);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (c) => const MyHomePage(),
                              ),
                            );
                          },
                        ),
                        // AppButton(
                        //     text: "Reset",
                        //     borderRadius: 5,
                        //     bgColor: Colors.red,
                        //     textColor: Colors.white,
                        //     fontSize: 15,
                        //     fontWeight: FontWeight.normal,
                        //     onTap: () => clearText())
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
