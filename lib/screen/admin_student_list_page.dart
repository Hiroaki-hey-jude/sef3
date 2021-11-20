import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

var currentUser = FirebaseAuth.instance.currentUser;

class StudentList {
  Future<QuerySnapshot> getData() async {
    return await FirebaseFirestore.instance
        .collection('students')
        .where("email", isEqualTo: currentUser!.email)
        .get();
  }
}

class AdminStudentListPage extends StatelessWidget {
  AdminStudentListPage({Key? key}) : super(key: key);
  final studentList = StudentList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<QuerySnapshot>(
        future: studentList.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final querySnaphost = snapshot.data; // Get query snapshot

            if (querySnaphost!.docs.isNotEmpty) {
              // Document exists
              final documentSnapshot =
                  querySnaphost.docs.first; // Get document snapshot
              return list(documentSnapshot, context); // Get the data
            } else {
              // Document does not exist
              return Text('Document does not exist.');
            }
          } else {
            // Show a loading widget
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget list(DocumentSnapshot documentSnapshot, BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('students').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return Card(
                child: ListTile(
                  title: Text(data['name']),
                ),
              );
            }).toList()
          );
        });
  }
}
