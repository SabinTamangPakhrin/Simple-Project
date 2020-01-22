import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/photomodel.dart';
import './eachPost.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String url = 'https://jsonplaceholder.typicode.com/photos';
  List<PhotoModel> photosList = [];
  int currentLenght = 0;
  final int increment = 10;
  bool isloading = false;
  bool disable = true;
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isloading = true;
    });
    for (var i = currentLenght; i <= currentLenght + increment; i++) {
      var apiItem = i + 1;
      http.Response response = await http.get('$url/$apiItem');
      Map<String, dynamic> parsedJson = json.decode(response.body);
      PhotoModel photo = PhotoModel.fromJson(parsedJson);
      photosList.add(photo);
    }
    setState(() {
      isloading = false;
      currentLenght = photosList.length;
    });
  }

  Future<void> getUserId() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String user = localStorage.getString('userId');
    return user;
  }

  Future<void> checkLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String user = localStorage.getString('userId');
    user == null
        ? Navigator.pushNamed(context, '/login')
        : Navigator.pushNamed(context, '/upload');
  }

  Future<void> removeUserId() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('userId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Revbook',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () {
              removeUserId();
            },
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
              child: Icon(
                Icons.search,
                size: 30,
              ),
              onTap: () {
                print('search page');
                // Navigator.pushNamed(context, '/profile');
              },
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: photosList == null ? 0 : photosList.length,
        itemBuilder: (context, index) {
          if (isloading && index == photosList.length - 1) {
            return CircularProgressIndicator();
          } else {
            return EachListPost(photosList[index]);
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 50,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.home, color: Colors.black),
                  color: Colors.white,
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.account_circle, color: Colors.black),
                  color: Colors.white,
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            checkLoggedIn();
          }),
    );
  }
}
