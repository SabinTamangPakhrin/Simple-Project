import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

enum authProblems { UserNotFound, PasswordNotValid, NetworkError }

class _LoginScreenState extends State<LoginScreen> {
  bool hidden = true;
  bool _loading = false;
  TextEditingController _emailC = TextEditingController();
  TextEditingController _passwordC = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Container(
        // color: Colors.greenAccent,
        margin: EdgeInsets.all(20),
        child: Form(
          key: _key,
          child: Column(
            children: <Widget>[
              Spacer(
                flex: 1,
              ),
              TextFormField(
                  controller: _emailC,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.supervisor_account),
                    hintText: 'Email',
                  ),
                  validator: (input) =>
                      input.isEmpty || !input.contains('@')
                          ? 'Invalid email'
                          : null),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordC,
                obscureText: hidden,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      icon: hidden
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          hidden = !hidden;
                        });
                      },
                    )),
                validator: (input) =>
                    input.isEmpty ? 'Empty password' : null,
              ),
              SizedBox(height: 5),
              SizedBox(height: 30),
              Container(
                height: 40,
                width: double.infinity,
                child: FlatButton(
                  color: Colors.black,
                  textColor: Colors.white,
                  child: Text(_loading ? 'Logging....' : 'LOGIN'),
                  onPressed: _loading
                      ? null
                      : () => login(_emailC.text, _passwordC.text),
                ),
              ),
              SizedBox(height: 30),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Don\'t have an account? '),
                    InkWell(
                      child: Text(
                        'Register',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
                      },
                    )
                  ],
                ),
              ),
              Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  login(String email, String password) async {
    setState(() {
      _loading = true;
    });
    //login with email and password
    if (_key.currentState.validate()) {
      print('email: $email password: $password');
      try {
        AuthResult result = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        FirebaseUser user = result.user;
        
        if (user != null) {
          SharedPreferences localStorage = await SharedPreferences.getInstance();
          localStorage.setString('userId', user.uid);
          var userId = localStorage.getString('userId');
          print('userId saved : $userId');
          Navigator.pop(context,userId);  

        } else {
          print('no user found');
        }
      } catch (e) {
        authProblems errorType;
        if (Platform.isAndroid) {
          switch (e.message) {
            case 'There is no user record corresponding to this identifier. The user may have been deleted.':
              errorType = authProblems.UserNotFound;
              // return showDialog('User not found.');
              break;
            case 'The password is invalid or the user does not have a password.':
              errorType = authProblems.PasswordNotValid;
              break;
            case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
              errorType = authProblems.NetworkError;
              break;
            // ...
            default:
              print('Case ${e.message} is not yet implemented');
          }
        }
        print('The error is $errorType');
      }
    }
    setState(() {
      _loading =false;
    });
  }

  showDialog(String error) {
    return AlertDialog(
      content: Text(error),
    );
  }
}
