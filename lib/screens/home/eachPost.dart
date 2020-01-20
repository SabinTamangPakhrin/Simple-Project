import 'package:flutter/material.dart';
import '../../models/photomodel.dart';

class EachListPost extends StatefulWidget {
  final PhotoModel eachPhoto;
  EachListPost(this.eachPhoto);

  @override
  _EachListPostState createState() => _EachListPostState();
}

class _EachListPostState extends State<EachListPost> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                // color: Colors.grey,
                child: Text(
                  (widget.eachPhoto.id).toString(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 30),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.eachPhoto.url), fit: BoxFit.fill),
            ),
            height: 380,
          ),
          Text('#hashtag'),
          Text('#description'),
          Row(
            children: <Widget>[
              IconButton(
                icon: widget.eachPhoto.liked ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
                onPressed: () {
                  setState(() {
                    widget.eachPhoto.liked  = !widget.eachPhoto.liked ;

                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.chat_bubble_outline),
                onPressed: () {
                  Navigator.pushNamed(context, '/comment');
                },
              )
            ],
          )
        ],
      ),
    );
  }
}