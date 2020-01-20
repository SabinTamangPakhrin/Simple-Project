import 'package:flutter/material.dart';

class EmailField extends StatefulWidget {
  @override
  _EmailFieldState createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        // controller: _emailC,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.supervisor_account),
          hintText: 'Email',
        ),
        validator: (input) =>
            input.isEmpty || !input.contains('@') ? 'Invalid email' : null);
  }
}
