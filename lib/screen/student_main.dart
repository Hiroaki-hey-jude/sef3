import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sef/screen/student_profile.dart';
import 'package:sef/screen/student_sign_out.dart';
import 'package:sef/screen/student_sign_up_page.dart';

class StudentMain extends StatefulWidget {
  const StudentMain({Key? key}) : super(key: key);

  @override
  _StudentMainState createState() => _StudentMainState();
}

class _StudentMainState extends State<StudentMain> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Row(
        children: [
          left(context),
          middle(context),
          right(context),
        ],
      ),
    );
  }

  Widget left(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.3,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          children:  [
            SizedBox(
              height: MediaQuery.of(context).size.height*0.3,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size(200, 80),
                ),
                  onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => StudentProfile()));
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.account_circle),
                      SizedBox(width: 5),
                      Text('Profile',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size(200, 80),
                  ),
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Icon(Icons.notifications),
                      SizedBox(width: 5),
                      Text('Notification',
                        style: TextStyle(
                        fontSize: 15,
                      ),),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size(200, 80),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => StudentSignOut()));
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.logout),
                      SizedBox(width: 5),
                      Text('log out',
                        style: TextStyle(
                        fontSize: 15,
                      ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget middle(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.4,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //const SizedBox(height: 100),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.4,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 80),
                ),
                  onPressed: () {},
                  child: const Text('Take Exam',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                    ),),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.4,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 80),
                ),
                onPressed: () {},
                child: const Text('View Result',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget right(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.3,
      height: MediaQuery.of(context).size.height,
    );
  }
}
