import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_database/pages/update_data.dart';

import 'add_data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  String? documentId = "7PhNmkUtmGZqFPv9Ze11";

  String? email;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  Future<void> deleteUser(id) {
    return users
        .doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Student DataBase"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddData())),
              child: const Text("Add"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
            ),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List storeData = [];
          snapshot.data!.docs.map(
            (DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              storeData.add(data);
              data['id'] = document.id;
              print(storeData);
            },
          ).toList();

          return Column(
            children: [
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                textDirection: TextDirection.ltr,
                border: TableBorder.all(),
                children: [
                  buildRow(['Name', 'Email', 'Action'], header: true),
                  for (int i = 0; i < storeData.length; i++)
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                              child: Text(storeData[i]['UserUID'] ?? "")),
                        ),
                        TableCell(
                          child: Center(
                              child: Text(storeData[i]['UserEmail'] ?? "")),
                        ),
                        TableCell(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UpdateData(
                                              dataId: storeData[i]["id"],
                                            ))),
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () => deleteUser(storeData[i]["id"]),
                                icon: const Icon(Icons.delete))
                          ],
                        ))
                      ],
                    )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}

buildRow(List<String> list, {bool header = false}) => TableRow(
        children: list.map((e) {
      var style = header == true
          ? const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
          : const TextStyle(fontSize: 15, fontWeight: FontWeight.normal);
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Text(
          e,
          style: style,
        )),
      );
    }).toList());
