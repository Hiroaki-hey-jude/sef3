import 'package:flutter/material.dart';
import 'package:sef/first_page.dart';
import 'package:sef/global/email_password_auth.dart';
import 'package:sef/global/enum.dart';
import 'package:sef/global/reg_exp.dart';
import '../common_auth.dart';
import 'admin_main.dart';
class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({Key? key}) : super(key: key);

  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final GlobalKey<FormState> _logInKey = GlobalKey();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final EmailPasswordAuth _emailPasswordAuth = EmailPasswordAuth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Container(
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: 56,
              ),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  'Log-In',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 1.5,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Form(
                  key: _logInKey,
                  child: ListView(
                    children: [
                      commonTextFormField(
                          hintText: 'Email',
                          validator: (inputVal) {
                            if (!emailRegex.hasMatch(inputVal.toString())) {
                              return 'Email format is not matching';
                            }
                            return null;
                          },
                          textEditingController: email),
                      commonTextFormField(
                          hintText: 'Password',
                          validator: (String? inputVal) {
                            if (inputVal!.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          textEditingController: password),
                      adminloginAuthButton(context, 'Log-In'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget adminloginAuthButton(BuildContext context, String buttonName) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(
            MediaQuery
                .of(context)
                .size
                .width - 60,
            40.0,
          ),
          elevation: 5.0,
          primary: Color.fromRGBO(57, 60, 80, 1),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
        child: Text(
          buttonName,
          style: const TextStyle(
            fontSize: 25.0,
            letterSpacing: 1.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        onPressed: () async {
          if (_logInKey.currentState!.validate()) {

            final EmailLogInResults emailLogInResults = await _emailPasswordAuth
                .logInWithEmailAndPassword(
                email: email.text, pwd: password.text);
            String message = '';
            if (emailLogInResults == EmailLogInResults.LogInCompleted) {
              Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (_) => AdminMain()), (
                  route) => false);
            } else if (emailLogInResults == EmailLogInResults.EmailNotVerified) {
              message =
              'Email not verified. \nPlease Verify your Email and then log in';
            } else
            if (emailLogInResults == EmailLogInResults.EmailPasswordInvalid) {
              message = 'Email And Password Invalid';
            } else {
              message = 'Sing in not completed';
            }

            if (message != '') {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)));
            }


            print('validated');
          } else {
            print('not validated');
          }
        },
      ),
    );
  }
}

// class AdminLoginPage extends StatefulWidget {
//   const AdminLoginPage({Key? key}) : super(key: key);
//
//   @override
//   _AdminLoginPageState createState() => _AdminLoginPageState();
// }
//
// class _AdminLoginPageState extends State<AdminLoginPage> {
//   final GlobalKey<FormState> _logInKey = GlobalKey();
//   final TextEditingController email = TextEditingController();
//   final TextEditingController password = TextEditingController();
//   final EmailPasswordAuth _emailPasswordAuth = EmailPasswordAuth();
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () {
//         Navigator.pop(context);
//         return Future(() => true);
//       },
//       child: Scaffold(
//         backgroundColor: Colors.green,
//         body: Container(
//           child: ListView(
//             shrinkWrap: true,
//             children: [
//               const SizedBox(
//                 height: 56,
//               ),
//               Container(
//                 alignment: Alignment.center,
//                 child: const Text(
//                   'Log-In',
//                   style: TextStyle(
//                     fontSize: 30.0,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               Container(
//                 height: MediaQuery
//                     .of(context)
//                     .size
//                     .height / 2.5,
//                 width: MediaQuery
//                     .of(context)
//                     .size
//                     .width,
//                 padding: const EdgeInsets.only(top: 20, bottom: 20),
//                 child: Form(
//                   key: _logInKey,
//                   child: ListView(
//                     children: [
//                       commonTextFormField(
//                           hintText: 'Email',
//                           validator: (inputVal) {
//                             if (!emailRegex.hasMatch(inputVal.toString())) {
//                               return 'Email format is not matching';
//                             }
//                             return null;
//                           },
//                           textEditingController: email),
//                       commonTextFormField(
//                           hintText: 'Password',
//                           validator: (String? inputVal) {
//                             if (inputVal!.length < 6) {
//                               return 'Password must be at least 6 characters';
//                             }
//                             return null;
//                           },
//                           textEditingController: password),
//                       loginAuthButton(context, 'Log-In'),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   Widget loginAuthButton(BuildContext context, String buttonName) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           minimumSize: Size(
//             MediaQuery
//                 .of(context)
//                 .size
//                 .width - 60,
//             40.0,
//           ),
//           elevation: 5.0,
//           primary: Color.fromRGBO(57, 60, 80, 1),
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(20)),
//           ),
//         ),
//         child: Text(
//           buttonName,
//           style: const TextStyle(
//             fontSize: 25.0,
//             letterSpacing: 1.0,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//         onPressed: () async {
//           if (_logInKey.currentState!.validate()) {
//
//             final EmailLogInResults emailLogInResults = await _emailPasswordAuth
//                 .logInWithEmailAndPassword(
//                 email: email.text, pwd: password.text);
//             String message = '';
//             if (emailLogInResults == EmailLogInResults.LogInCompleted) {
//               Navigator.pushAndRemoveUntil(
//                   context, MaterialPageRoute(builder: (_) => AdminMain()), (
//                   route) => false);
//             } else if (emailLogInResults == EmailLogInResults.EmailNotVerified) {
//               message =
//               'Email not verified. \nPlease Verify your Email and then log in';
//             } else
//             if (emailLogInResults == EmailLogInResults.EmailPasswordInvalid) {
//               message = 'Email And Password Invalid';
//             } else {
//               message = 'Sing in not completed';
//             }
//
//             if (message != '') {
//               ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text(message)));
//             }
//
//
//             print('validated');
//           } else {
//             print('not validated');
//           }
//         },
//       ),
//     );
//   }
// }
