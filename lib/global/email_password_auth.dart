import 'package:firebase_auth/firebase_auth.dart';
import 'package:sef/global/enum.dart';

class EmailPasswordAuth{
  Future<EmailSignResults> signUpAuth ({required String email, required String password})async{
    try{
      final UserCredential userCredential = await FirebaseAuth.instance.
      createUserWithEmailAndPassword(email: email, password: password);
      if(userCredential.user!.email != null){
        await userCredential.user!.sendEmailVerification();
        return EmailSignResults.SignUpCompleted;
      }
      return EmailSignResults.SignUpNotCompleted;
    }catch(e){
      print('why');
      print('error in sign up ${e.toString()}');
      return EmailSignResults.EmailAlreadyPresent;
    }
  }

  Future<EmailLogInResults> logInWithEmailAndPassword(
      {required String email, required String pwd}) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pwd);
      if (userCredential.user!.emailVerified) {
        return EmailLogInResults.LogInCompleted;
      } else{
        final bool logOutResponse = await logOut();
        if(logOutResponse) {
          return EmailLogInResults.EmailNotVerified;
        }
        return EmailLogInResults.UnexpectedError;
      }
    } catch (e) {
      print('error in Email and Password Authentication: ${e.toString()}');
      return EmailLogInResults.EmailPasswordInvalid;
    }
  }

  Future<bool> logOut()async{
    try{
      await FirebaseAuth.instance.signOut();
      return true;
    }catch(e){
      return false;
    }
  }
}