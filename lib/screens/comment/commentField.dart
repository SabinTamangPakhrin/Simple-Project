import 'package:flutter/material.dart';

class CommentField extends StatefulWidget {
  @override
  _CommentFieldState createState() => _CommentFieldState();
}

class _CommentFieldState extends State<CommentField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Comment',
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          )),
    );
  }
}
