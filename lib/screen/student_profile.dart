import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

var currentUser = FirebaseAuth.instance.currentUser;

class Crud {
  Future<QuerySnapshot> getData() async {
    return await FirebaseFirestore.instance
        .collection('students')
        .where("email", isEqualTo: currentUser!.email)
        .get();
  }
}

class StudentProfile extends StatefulWidget {
  const StudentProfile({Key? key}) : super(key: key);

  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  //CollectionReference users = FirebaseFirestore.instance.collection('users');
  final crud = Crud();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: crud.getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final querySnaphost = snapshot.data; // Get query snapshot

          if (querySnaphost!.docs.isNotEmpty) {
            // Document exists
            final documentSnapshot =
                querySnaphost.docs.first; // Get document snapshot
            return profilePage(documentSnapshot); // Get the data
          } else {
            // Document does not exist
            return Text('Document does not exist.');
          }
        } else {
          // Show a loading widget
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget profilePage(DocumentSnapshot documentSnapshot) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.account_circle),
            SizedBox(width: 5),
            Text('Profile'),
          ],
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width*0.6,
          height: MediaQuery.of(context).size.height/2,
          child: Column(
            children: [
              Row(
                children:  [
                  Text('Student ID:'),
                  Text('${documentSnapshot.get('id')}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
