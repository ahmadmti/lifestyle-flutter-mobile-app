import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class authenticate {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //signIn anom
  Future signInAnom() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //signIn with email and password
  Future signInWithEmailAndPassword(String _emailController, String _passwordController) async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController,
        password: _passwordController,
      ))
          .user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //register with email and password

  Future register(String _emailController, String _passwordController) async {
    try {
      final User user =
          (await _auth.createUserWithEmailAndPassword(email: _emailController, password: _passwordController)).user;
      return user;
    } catch (e) {
      return null;
    }
  }

  //sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

//change pwd
  Future<void> updatePassword(String _passwordController) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString("email");
    var password = pref.getString("password");
    User user = FirebaseAuth.instance.currentUser;
    var credentials = EmailAuthProvider.getCredential(email: email, password: password);
    await user.reauthenticateWithCredential(credentials);

    await _auth.currentUser.updatePassword(_passwordController);
  }

  //change email
  Future<void> updateEmail(String _emailController) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString("email");
    var password = pref.getString("password");
    User user = FirebaseAuth.instance.currentUser;
    var credentials = EmailAuthProvider.getCredential(email: email, password: password);
    await user.reauthenticateWithCredential(credentials);
    await _auth.currentUser.updateEmail(_emailController);

    return null;
  }
}
