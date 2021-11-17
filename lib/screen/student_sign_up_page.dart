import 'package:flutter/material.dart';
import 'package:sef/global/email_password_auth.dart';
import 'package:sef/global/enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sef/global/reg_exp.dart';
import 'package:sef/screen/lecture_login_page.dart';
import 'package:sef/screen/student_login_page.dart';

import '../common_auth.dart';

class StudentSignUpPage extends StatefulWidget {
  const StudentSignUpPage({Key? key}) : super(key: key);

  @override
  _StudentSignUpPageState createState() => _StudentSignUpPageState();
}

class _StudentSignUpPageState extends State<StudentSignUpPage> {
  final GlobalKey<FormState> _signUpKey = GlobalKey();
  final TextEditingController email = TextEditingController();
  final TextEditingController studentId = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController number = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confPass = TextEditingController();
  final EmailPasswordAuth emailPasswordAuth = EmailPasswordAuth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Registration'),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top: 40, bottom: 40),
              child: Form(
                key: _signUpKey,
                child: ListView(
                  children: [
                    commonTextFormField(
                      hintText: 'Enter MMU ID',
                      validator: (inputVal) {
                        if (inputVal!.isEmpty) {
                          return 'Enter correct MMU ID';
                        }
                        return null;
                      },
                      textEditingController: studentId,
                    ),
                    commonTextFormField(
                      hintText: 'Enter your Name',
                      validator: (inputVal) {
                        if (inputVal!.length < 3) {
                          return 'Enter valid name';
                        }
                        return null;
                      },
                      textEditingController: name,
                    ),
                    commonTextFormField(
                      hintText: 'Enter your MMU Email',
                      validator: (inputVal) {
                        if(!inputVal.toString().contains('@student.mmu.edu.my')){
                          return 'Email format not Matching';
                        }
                        if (!emailRegex.hasMatch(inputVal.toString())){
                          return 'Email format not Matching';
                        }
                        return null;
                      },
                      textEditingController: email,
                    ),
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
                      hintText: 'Confirm Password',
                      validator: (inputVal) {
                        if (inputVal!.length < 6) {
                          return 'Confirm Password must be at least 6 characters';
                        }
                        if (password.text != confPass.text) {
                          return 'Confirm password and Password not same';
                        }
                        return null;
                      },
                      textEditingController: confPass,
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
                    studentSignUpAuthButton(context, 'Register'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget studentSignUpAuthButton(BuildContext context, String buttonName) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(MediaQuery.of(context).size.width - 60, 40),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        child: Text(
          buttonName,
          style: const TextStyle(
            fontSize: 25,
            letterSpacing: 1.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () async {
          if (_signUpKey.currentState!.validate()) {
            print('validated');

            FirebaseFirestore.instance.collection('students')
                .add({
              'address': address.text,
              'id': studentId.text,
              'email': email.text,
              'name': name.text,
              'number': number.text,
              'password': password.text
            }).then((value) => print(value.id));

            final EmailSignResults response = await emailPasswordAuth
                .signUpAuth(
                email: email.text, password: password.text);
            if (response == EmailSignResults.SignUpCompleted) {
              Navigator.push(context, MaterialPageRoute(builder: (_) => StudentLogInPage()));
            } else {
              final String message =
              response == EmailSignResults.EmailAlreadyPresent
                  ? 'Email already Present'
                  : 'Sign Up Completed';
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
            }
          } else {
            print('not Validated');
          }
        },
      ),
    );
  }
}
