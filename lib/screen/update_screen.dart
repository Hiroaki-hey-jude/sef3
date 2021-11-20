import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sef/screen/student_profile.dart';

import '../common_auth.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final crud = Crud();
  // QuerySnapshot docuID = FirebaseFirestore.instance
  //     .collection('students')
  //     .where("email", isEqualTo: currentUser!.email)
  //     .get();
  final GlobalKey<FormState> _signUpKey = GlobalKey();
  final TextEditingController number = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController password = TextEditingController();
  var currentUser = FirebaseAuth.instance.currentUser;
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
              return updateStudentInfo(context, documentSnapshot); // Get the data
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


  Widget updateStudentInfo(BuildContext context, DocumentSnapshot documentSnapshot) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: _signUpKey,
              child: ListView(
                children: [
                  commonTextFormField(
                    hintText: 'Enter your MMU Password',
                    validator: (inputVal) {
                      if (inputVal!.length < 6) {
                        return 'password must be more than 6 words';
                      }
                      return null;
                    },
                    textEditingController: password,
                  ),
                  commonTextFormField(
                    hintText: 'Enter your Number',
                    validator: (inputVal) {
                      if (inputVal!.length < 6) {
                        return 'number must be more than 6 numbers';
                      }
                      return null;
                    },
                    textEditingController: number,
                  ),
                  commonTextFormField(
                    hintText: 'Enter your Address',
                    validator: (inputVal) {
                      if (inputVal!.length < 6) {
                        return 'Please Enter valid address';
                      }
                      return null;
                    },
                    textEditingController: address,
                  ),
                  SizedBox(height: 10),
                  updateStudentInfoButton(context, 'Update', documentSnapshot),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget updateStudentInfoButton(BuildContext context, String s, DocumentSnapshot documentSnapshot) {
    return ElevatedButton(
        onPressed: () {
          currentUser!.updatePassword(password.text);
          FirebaseFirestore.instance.collection('students').doc(documentSnapshot.id).update({
            'number': number.text,
            'password': password.text,
            'address': address.text,
          });
          Navigator.push(context, MaterialPageRoute(builder: (context) => StudentProfile()));
        },
        child: Text(s),
    );
  }

}
