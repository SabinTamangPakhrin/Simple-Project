import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(radius: 50),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Username'),
                      Text('About me'),
                      Text('Email')
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: FlatButton(
                child: Text('Edit Profile'),
                textColor: Colors.white,
                color: Colors.black,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
