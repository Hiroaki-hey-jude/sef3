import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sef/model/student.dart';
import 'package:sef/screen/student_main.dart';
import 'package:sef/screen/update_screen.dart';

import '../common_auth.dart';

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
  final GlobalKey<FormState> _signUpKey = GlobalKey();
  final TextEditingController password = TextEditingController();
  final TextEditingController number = TextEditingController();
  final TextEditingController address = TextEditingController();
  String? name;
  String? studentId;
  String? email;
  //CollectionReference users = FirebaseFirestore.instance.collection('users');
  final crud = Crud();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<QuerySnapshot>(
        future: crud.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final querySnaphost = snapshot.data; // Get query snapshot

            if (querySnaphost!.docs.isNotEmpty) {
              // Document exists
              final documentSnapshot =
                  querySnaphost.docs.first; // Get document snapshot
              Student.instance.studentName = documentSnapshot.get('name');
              Student.instance.studentId = documentSnapshot.get('id');
              Student.instance.studentEmail = documentSnapshot.get('email');
              Student.instance.studentPassword = documentSnapshot.get('password');
              Student.instance.studentPhoneNum = documentSnapshot.get('number');
              Student.instance.studentAddress = documentSnapshot.get('address');
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
      ),
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
      body: Column(
        children: [
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width/2,
                height: MediaQuery.of(context).size.height*0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Student ID:'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Name:'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Email:'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Password:'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Number:'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Address:'),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width/2,
                height: MediaQuery.of(context).size.height*0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(Student.instance.studentId!),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(Student.instance.studentName!),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(Student.instance.studentEmail!),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(Student.instance.studentPassword!),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(Student.instance.studentPhoneNum!),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(Student.instance.studentAddress!),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateScreen()));
                    },
                    child: Text('Update'),
                  ),
                ),
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => StudentMain()));
                  },
                  child: Text('back'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}
