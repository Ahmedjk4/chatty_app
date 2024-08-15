import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  const AuthService();

  static Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'user-not-found') {
    //     showSnackBar(context, 'User not found');
    //   } else if (e.code == 'wrong-password') {
    //     showSnackBar(context, 'Wrong password provided for that user.');
    //   } else if (e.code == 'invalid-credential') {
    //     showSnackBar(context, 'Invalid email or password.');
    //   } else if (e.code == 'network-request-failed') {
    //     showSnackBar(
    //         context, 'Network error. Please check your internet connection.');
    //   } else {
    //     showSnackBar(context, 'Authentication error: ${e.message}');
    //   }
    // } on SocketException {
    //   showSnackBar(
    //       context, 'Network error. Please check your internet connection.');
    // } catch (e) {
    //   showSnackBar(
    //       context,
    //       'Unexpected error. Please try again later. \n'
    //       'Error: ${e.toString()}');
    // }
  }

  static Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
    await FirebaseAuth.instance.currentUser?.updatePhotoURL(
        'https://ui-avatars.com/api/?background=random&name=$name&format=png&size=256');
    // await FirebaseAuth.instance.verifyPhoneNumber(

    // );
  }

  static Future<void> resetPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    // showSnackBar(context, 'Password reset email sent.');
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'network-request-failed') {
    //     showSnackBar(
    //         context, 'Network error. Please check your internet connection.');
    //   } else {
    //     showSnackBar(context, 'Reset password error: ${e.message}');
    //   }
    // } on SocketException {
    //   showSnackBar(
    //       context, 'Network error. Please check your internet connection.');
    // } catch (e) {
    //   log(e.toString());
    //   showSnackBar(
    //       context,
    //       'Unexpected error. Please try again later. \n'
    //       'Error: ${e.toString()}');
    // }
  }

  static Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> updateName(String name) async {
    await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
    await FirebaseAuth.instance.currentUser?.reload();
  }
}
