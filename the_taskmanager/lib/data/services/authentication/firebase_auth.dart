import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_taskmanager/common/widgets/snackbar.dart';
import 'package:the_taskmanager/utils/constants/enums.dart';

class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'email-already-in-use') {
        CustomSnackBar.showSnackBar(
            title: "Error",
            message: "The email is already in use",
            type: SnackBarType.warning);
        return null;
      } else {
        CustomSnackBar.showSnackBar(
            title: "Error",
            message: "An error is Occurred ${e.code}",
            type: SnackBarType.warning);
        return null;
      }
    }
    return null;
  }

  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      CustomSnackBar.showSnackBar(
          title: "Alert", message: e.toString(), type: SnackBarType.warning);
      print("Some error occured");
    }
    return null;
  }

// Future signInWithGoogle() async {
//   try {
//     final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
//
//     final GoogleSignInAuthentication gAuth = await gUser!.authentication;
//
//     final credential = GoogleAuthProvider.credential(
//         accessToken: gAuth.accessToken, idToken: gAuth.idToken);
//
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   } on FirebaseAuthException catch (e) {
//     commonToast( "An error is Occurred ${e.code}");
//   }
// }
}
