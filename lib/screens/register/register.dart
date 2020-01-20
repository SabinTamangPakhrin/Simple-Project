import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../api/apihandler.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _loading = false;
  final _key = GlobalKey<FormState>();
  TextEditingController _nameC = TextEditingController();
  TextEditingController _emailC = TextEditingController();
  TextEditingController _passwordC = TextEditingController();
  TextEditingController _passwordCC = TextEditingController();


  //handle login  Firebase
  handleSignUp(String email, String password) async {
    if (_key.currentState.validate()) {
      print('email: $email password: $password');
      try {
        setState(() {
          _loading = true;
        });
        AuthResult result = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(result);
        FirebaseUser user = result.user;
        print(user);
        setState(() {
          _loading = false;
        });
        Navigator.pop(context);
      } catch (e) {
        Exception('Error: $e');
        setState(() {
          _loading = false;
        });
      }
    }
  }


  //handle login  API
  handlelogin() async {
    setState(() {
      _loading = true;
    });

    Map data = {
      'name': _nameC.text,
      'email': _emailC.text,
      'password': _passwordCC.text,
    };

    var res = await ApiProvider().postData(data, '/register');
    var body = json.decode(res);
    print(body);
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Form(
            key: _key,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _nameC,
                  decoration: InputDecoration(
                    hintText: 'Name',
                  ),
                  validator: (input) =>
                      input.isEmpty ? 'Empty Name Found' : null,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailC,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: 'Email'),
                  validator: (input) =>
                      input.isEmpty || !input.contains('@') ? 'Invalid' : null,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordC,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Password'),
                  validator: (input) =>
                      input.isEmpty ? 'Empty passsword.' : null,
                ),
                SizedBox(height: 20),
                TextFormField(
                    controller: _passwordCC,
                    obscureText: true,
                    decoration: InputDecoration(hintText: 'Confirm Password'),
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Empty Confirm Password';
                      } else if (!(input == _passwordC.text)) {
                        return 'Password doesnot matched.';
                      }
                      return null;
                    }),
                SizedBox(height: 30),
                Container(
                  height: 40,
                  width: double.infinity,
                  child: FlatButton(
                    color: Colors.black,
                    textColor: Colors.white,
                    child: Text(_loading ? 'Registering....' : 'REGISTER'),
                    onPressed: _loading
                        ? null
                        : () => handleSignUp(_emailC.text, _passwordCC.text),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Already have an account? '),
                    InkWell(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
