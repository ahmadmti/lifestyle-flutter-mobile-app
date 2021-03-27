import 'package:flutter/material.dart';
import 'package:lifestyle/mainHome.dart';
import 'package:login_fresh/login_fresh.dart';
import 'package:lifestyle/authenticate/authenticate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

final authenticate _auth = authenticate();

class loginClass extends StatefulWidget {
  @override
  _loginClassState createState() => _loginClassState();
}

class _loginClassState extends State<loginClass> {
  @override
  Widget build(BuildContext context) {
    return buildLoginFresh();
  }

  LoginFresh buildLoginFresh() {
    List<LoginFreshTypeLoginModel> listLogin = [
      LoginFreshTypeLoginModel(
          callFunction: (BuildContext _buildContext) {
            Navigator.of(_buildContext).push(MaterialPageRoute(
              builder: (_buildContext) => widgetLoginFreshUserAndPassword(),
            ));
          },
          logo: TypeLogo.userPassword),
    ];

    return LoginFresh(
      pathLogo: 'images/logo_icon.png',
      isExploreApp: false,
      functionExploreApp: () {
        // develop what they want the ExploreApp to do when the user clicks
      },
      isFooter: true,
      widgetFooter: this.widgetFooter(),
      typeLoginModel: listLogin,
      isSignUp: true,
      widgetSignUp: this.widgetLoginFreshSignUp(),
    );
  }

  Widget widgetLoginFreshUserAndPassword() {
    return LoginFreshUserAndPassword(
      callLogin: (BuildContext _context, Function isRequest, String user, String password) {
        isRequest(true);

        Future.delayed(Duration(seconds: 2), () async {
          print('-------------- function call----------------');
          dynamic result = await _auth.signInWithEmailAndPassword(user, password);
          if (result == null) {
            Fluttertoast.showToast(
                msg: "Login Failed.. Check Email and Password..",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            Fluttertoast.showToast(
                msg: "Login Successful..",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('uid', result.uid);
            await prefs.setString('email', user);
            await prefs.setString('password', password);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => mainHome()), (Route<dynamic> route) => false);
          }
          print('--------------   end call   ----------------');

          isRequest(false);
        });
      },
      logo: 'images/logo_icon.png',
      isFooter: true,
      widgetFooter: this.widgetFooter(),
      isResetPassword: true,
      widgetResetPassword: this.widgetResetPassword(),
      isSignUp: true,
      signUp: this.widgetLoginFreshSignUp(),
    );
  }

  Widget widgetResetPassword() {
    return LoginFreshResetPassword(
      logo: 'images/logo_icon.png',
      funResetPassword: (BuildContext _context, Function isRequest, String email) {
        isRequest(true);
        Fluttertoast.showToast(
            msg: "Password Reset Email has been sent.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => loginClass()),
        );
        Future.delayed(Duration(seconds: 2), () async {
          print('-------------- function call----------------');
          print(email);
          print('--------------   end call   ----------------');
          isRequest(false);
        });
      },
      isFooter: true,
      widgetFooter: this.widgetFooter(),
    );
  }

  Widget widgetFooter() {
    return LoginFreshFooter(
      logo: 'images/logoOS.png',
      text: ' ',
      funFooterLogin: () {
        // develop what they want the footer to do when the user clicks
      },
    );
  }

  Widget widgetLoginFreshSignUp() {
    return LoginFreshSignUp(
        isFooter: true,
        widgetFooter: this.widgetFooter(),
        logo: 'images/logo_icon.png',
        funSignUp: (BuildContext _context, Function isRequest, SignUpModel signUpModel) async {
          isRequest(true);
          dynamic result = await _auth.register(signUpModel.email, signUpModel.password);

          if (result == null) {
            Fluttertoast.showToast(
                msg: "Sign up failed.",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            isRequest(false);
          } else {
            Fluttertoast.showToast(
                msg: "SignUp Successfull",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            Map userDataMap = {
              "name": signUpModel.name.trim(),
              "email": signUpModel.email.trim(),
              "dob": signUpModel.dob.trim()??'',
              "gender": signUpModel.gender.trim()??'',
            };
            usersRef.child(result.uid).set(userDataMap);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('uid', result.uid);
             await prefs.setString('email', signUpModel.email);
            await prefs.setString('password', signUpModel.password);
            isRequest(false);
           Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => mainHome()), (Route<dynamic> route) => false);
            
          }
          print(signUpModel.email);
          print(signUpModel.password);
          print(signUpModel.repeatPassword);
          print(signUpModel.nationality);
          print(signUpModel.name);
        });
  }
}
